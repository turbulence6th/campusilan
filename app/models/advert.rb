class Advert < ActiveRecord::Base
  
  belongs_to :user
  
  has_many :viewed_adverts
  has_many :users, through: :viewed_adverts
  
  has_many :favourite_adverts
  has_many :users, through: :favourite_adverts
  
  belongs_to :advertable, :polymorphic => true
  
end
