class User < ActiveRecord::Base
  
  has_secure_password
  
  enum :gender => [ :male, :female, :other ]
  enum :role => [ :admin, :member ]
  
  has_many :adverts, :dependent => :destroy
  
  has_many :viewed_adverts
  has_many :adverts, through: :viewed_adverts
  
  has_many :favourite_adverts
  has_many :adverts, through: :favourite_adverts
  
  has_many :froms, :class_name => 'Message', :foreign_key => 'id'
  has_many :tos, :class_name => 'Message', :foreign_key => 'id'
  
end
