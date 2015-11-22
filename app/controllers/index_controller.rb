class IndexController < ApplicationController

  layout false

  helper_method :current_user
  def index
    
  end
  
  def satis_alis
      
  end
  
  def insert_image
    @image = Image.new
  end 
  
  def insert_image_post
    @image = Image.new(params.require(:image).permit(:imagefile))
    current_user.image = @image
    redirect_to '/insert_image'
  end 

end
