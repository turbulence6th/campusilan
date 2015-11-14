class University < ActiveRecord::Base
  
  has_many :users
  
  validates :name, :email, :presence => true
  validates :name, :email, :uniqueness => true
  
end
