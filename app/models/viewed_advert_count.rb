class ViewedAdvertCount < ActiveRecord::Base
  
  validates :advert, :uniqueness => { :scope => :ip }
  
  validates :advert, :ip, :presence => true
  
  belongs_to :advert
  
end
