class Advert < ActiveRecord::Base
  
  validates :name, :price, :explication, :user, :advertable, :presence => true
  
  validates :active, :inclusion => { :in => [true, false] }
  
  validates :name, :format => {
    :with => /\A[ -~\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]{1,60}\z/
  }
  
  validates :price, :numericality => { :only_integer => true }
  
  validates :price, :length => {
    :maximum => 7
  }
  
  validates :explication, :length => {
    :maximum => 1000
  }
  
  validates :images, :length => {
    :minimum => 1,
    :maximum => 5
  }
  
  belongs_to :user
  
  has_many :viewed_adverts
  has_many :users, through: :viewed_adverts
  
  has_many :favourite_adverts
  has_many :users, through: :favourite_adverts
  
  belongs_to :advertable, :polymorphic => true
  
  has_many :images, :as => :imageable
  
end
