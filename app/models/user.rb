class User < ActiveRecord::Base
  
  has_secure_password
  
  enum :gender => [ :male, :female, :other ]
  enum :role => [ :admin, :member ]
  
  has_many :viewed_adverts
  has_many :adverts, through: :viewed_adverts
  
  has_many :favourite_adverts
  has_many :adverts, through: :favourite_adverts
  
end
