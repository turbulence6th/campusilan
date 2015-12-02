class ViewedAdvert < ActiveRecord::Base
  
  validates :user, :uniqueness => {:scope => :advert}
  
  validates :user, :advert, :presence => true
  
  belongs_to :user
  belongs_to :advert
  
  
end
