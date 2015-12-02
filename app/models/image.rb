class Image < ActiveRecord::Base

  belongs_to :imageable, :polymorphic => true

  has_attached_file :imagefile, :styles => { :small => "280x320!", :medium => "480x640!", :original => '768x1024!' },
    :url => "/image/:hash.:extension", :hash_secret => ":id"

  validates_attachment :imagefile, content_type: { content_type: /\Aimage\/.*\Z/ }, :size => { :in => 0..2.megabytes }

  validates :imagefile, :attachment_presence => true
  
end
