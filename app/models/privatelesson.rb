class Privatelesson < ActiveRecord::Base

  validates :kind, :lecture, :state, :city, :location, :presence => true

  enum :kind => [ :birebir, :grup, :sinifdersi ]

  enum :lecture => [ :matematik, :fizik, :kimya, :biyoloji, :genelmuhendislik, :genelegitimbilimleri]

  enum :location => [ :ogrencievi, :ogretmenevi, :sinifta ]
  
  has_one :advert, :as => :advertable

end
