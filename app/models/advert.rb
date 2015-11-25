class Advert < ActiveRecord::Base
  
  validates :name, :price, :explication, :user, :advertable, :presence => true
  
  validates :active, :inclusion => { :in => [true, false] }
  
  belongs_to :user
  
  has_many :viewed_adverts
  has_many :users, through: :viewed_adverts
  
  has_many :favourite_adverts
  has_many :users, through: :favourite_adverts
  
  belongs_to :advertable, :polymorphic => true
  
  has_many :image, :as => :imageable
  
end
