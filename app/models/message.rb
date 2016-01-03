class Message < ActiveRecord::Base
  
  belongs_to :from, :class_name => 'User'
  belongs_to :to, :class_name => 'User'
  
  validates :from, :to, :topic, :presence => true
  
  validates :text, :length => {
    :maximum => 500
  }
  
  scope :valid_to, -> {where('todeleted=false or todeleted is null') }
  
  scope :valid_from, -> {where('fromdeleted=false or fromdeleted is null') }
  
  
end
