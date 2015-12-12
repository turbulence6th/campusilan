class Image < ActiveRecord::Base

  belongs_to :imageable, :polymorphic => true

  has_attached_file :imagefile, :styles => { :small => "320x320!", :original => '800x1000!' },
    :url => "/image/:hash.:extension", :hash_secret => ":id", :default_url => "/resources/images/default.png"

  validates_attachment :imagefile, content_type: { content_type: ['image/jpeg', 'image/png'] }, :size => { :in => 0..2.megabytes }

  validates :imagefile, :attachment_presence => true
  
end
