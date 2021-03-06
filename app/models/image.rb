class Image < ActiveRecord::Base

  belongs_to :imageable, :polymorphic => true
  
  belongs_to :user

  has_attached_file :imagefile, :styles => { :small => "373x373!", :original => '800x600!' },
    :url => "/image/#{Rails.env}#{ENV['RAILS_TEST_NUMBER']}/:hash.:extension", :hash_secret => ":id", :default_url => "/resources/images/default.png"

  validates_attachment :imagefile, content_type: { content_type: ['image/jpeg', 'image/png'] }, :size => { :in => 0..2.megabytes }

  validates :imagefile, :attachment_presence => true
  validates :user, :presence => true
  
end
