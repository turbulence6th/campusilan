class Message < ActiveRecord::Base
  
  belongs_to :from, :class_name => 'User'
  belongs_to :to, :class_name => 'User'
  
  validates :from,:to, :topic,  :presence => true
  
  validates :text, :length => {
    :maximum => 500
  }
  
end
