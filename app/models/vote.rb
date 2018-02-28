class Vote < ActiveRecord::Base
  
  validates :user, :uniqueness => {:scope => :advert}
  
  validates :user, :advert, :point, :presence => true
  
  validates :point, :numericality => {
    :greater_than_or_equal_to => 1,
    :less_than_or_equal_to => 5
  }
  
  belongs_to :user
  belongs_to :advert
  
end
