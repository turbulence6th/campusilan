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
  
  def ilanver
    
    @secondhand = Secondhand.new
    @advert = Advert.new(:advertable => @secondhand) 
  end
  
  def ilanverPost
    @secondhand = Secondhand.new(params.require(:advert).require(:advertable).permit(
      :category, :color, :brand, :usage, :warranty))
    @advert = Advert.new(params.require(:advert).permit(:name, :price, :explication))
    @advert.advertable = @secondhand
    @advert.user = current_user
    @advert.active = true
    @advert.save
    
    redirect_to "/"
  end

end
