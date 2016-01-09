class Vote < ActiveRecord::Base
  
  validates :user, :uniqueness => {:scope => :advert}
  
  validates :user, :advert, :point, :presence => true
  
  belongs_to :user
  belongs_to :advert
  
end
