class Privatelesson < ActiveRecord::Base

  validates :kind, :lecture, :state, :city, :location, :presence => true

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
