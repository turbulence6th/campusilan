class IndexController < ApplicationController

  layout false

  helper_method :current_user
  def index
    
    @ensonikinciel = Advert.where(advertable_type: 'Secondhand').last(4).reverse
    @ensonevarkadasi = Advert.where(advertable_type: 'Homemate').last(4).reverse
    @ensondersnotu = Advert.where(advertable_type: 'Lessonnote').last(4).reverse
    @ensonozelders = Advert.where(advertable_type: 'Privatelesson').last(4).reverse
    
    @acililanlar = Advert.where(:urgent => true).order('created_at DESC').last(7)
    
  end
  
  def insert_image
    @image = Image.new
  end 
  
  def insert_image_post
    @image = Image.new(params.require(:image).permit(:imagefile))
    current_user.image = @image
    redirect_to '/insert_image'
  end 
  
  def satis_alis
    
  end
  
  

end
