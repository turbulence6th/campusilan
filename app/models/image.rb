class Image < ActiveRecord::Base
  
  belongs_to :imageable, :polymorphic => true
  
  has_attached_file :imagefile, :styles => { :small => "320x280>", :medium => "640x480>", :large => '1024x768>' },
    :url => "/image/:basename_:id_:style.:extension"
    
  validates_attachment :imagefile, content_type: { content_type: /\Aimage\/.*\Z/ }, :size => { :in => 0..2.megabytes }
  
  validates :imagefile, :attachment_presence => true
  
end
