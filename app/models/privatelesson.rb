class Privatelesson < ActiveRecord::Base
  
  has_one :advert, :as => :advertable
  
  validates :type,:lecture,:state,:city,:location, :presence => true
  
    enum :kind => [ :birebir, :grup, :sinifdersi ]
    
    enum :lecture => [ :matematik, :fizik, :kimya, :biyoloji, :genelmuhendislik, :genelegitimbilimleri]
      
      enum :location => [ :ogrencievi, :ogretmenevi, :sinifta ]
      
      
  
end
