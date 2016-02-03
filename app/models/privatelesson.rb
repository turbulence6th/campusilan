class Privatelesson < ActiveRecord::Base

  validates :kind, :lecture, :state, :city, :location, :presence => true

  validates :state, :city, :format => {
    :with => /\A[a-zA-Z0-9.-_ \u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]{1,20}\z/
  }

  enum :kind => [ :birebir, :grup, :sinifdersi ]

  enum :lecture => [ :matematik, :fizik, :kimya, :biyoloji, :genelmuhendislik, :genelegitimbilimleri, :siyasalbilimler, :diger]

  enum :location => [ :ogrencievi, :ogretmenevi, :sinifta, :farketmez ]

  has_one :advert, :as => :advertable
  def locationType
    if self.location=='ogrencievi'
      return "Öğrenci Evi"

    elsif self.location=='ogretmenevi'
      return "Öğretmen Evi"

    elsif self.location=='sinifta'
      return "Sınıfta"
      
      elsif self.location=='farketmez'
      return "Farketmez"

    end

  end

  def ozelderssekli

    if self.kind == 'birebir'

      return "Bire Bir"

    elsif self.kind == 'grup'

      return "Grup"

    elsif self.kind == 'sinifdersi'

      return "Sınıf Dersi"

    end

  end

  def derskategori

    if self.lecture == "matematik"

      return "Matematik"

    elsif self.lecture == "fizik"

      return "Fizik"

    elsif self.lecture == "kimya"

      return "Kimya"

    elsif self.lecture == "biyoloji"

      return "Biyoloji"

    elsif self.lecture == "genelmuhendislik"

      return "Genel Mühendislik"

    elsif self.lecture == "genelegitimbilimleri"

      return "Genel Eğitim Bilimleri"
      
      
      
    elsif self.lecture == "siyasalbilimler"

      return "Siyasal Bilimler"
      
      
    elsif self.lecture == "diger"

      return "Diğer"

    end

  end

end
