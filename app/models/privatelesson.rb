class Privatelesson < ActiveRecord::Base

  validates :kind, :lecture, :state, :city, :location, :presence => true

  validates :state, :city, :format => {
    :with => /\A[a-zA-Z\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]{1,20}\z/
  }

  enum :kind => [ :birebir, :grup, :sinifdersi ]

  enum :lecture => [ :matematik, :fizik, :kimya, :biyoloji, :genelmuhendislik, :genelegitimbilimleri]

  enum :location => [ :ogrencievi, :ogretmenevi, :sinifta ]

  has_one :advert, :as => :advertable
  def locationType
    if self.location=='ogrencievi'
      return "Öğrenci Evi"

    elsif self.location=='ogretmenevi'
      return "Öğretmen Evi"

    elsif self.location=='sinifta'
      return "Sınıfta"

    end

  end

end
