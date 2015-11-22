class Image < ActiveRecord::Base

  belongs_to :imageable, :polymorphic => true

  has_attached_file :imagefile, :styles => { :small => "320x280>", :medium => "640x480>", :original => '1024x768>' },
    :url => "/image/:hash.:extension", :hash_secret => ":id"

  validates_attachment :imagefile, content_type: { content_type: /\Aimage\/.*\Z/ }, :size => { :in => 0..2.megabytes }

  validates :imagefile, :attachment_presence => true
  
  after_save :delete_me
  
  private
  def delete_me
    self.destroy if !self.imageable
  end

end
