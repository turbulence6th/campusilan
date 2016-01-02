class IndexController < ApplicationController

  layout false

  helper_method :current_user
  def index

    @ensonikinciel = Advert.where(advertable_type: 'Secondhand').last(4).reverse
    @ensonevarkadasi = Advert.where(advertable_type: 'Homemate').last(4).reverse
    @ensonozelders = Advert.where(advertable_type: 'Privatelesson').last(4).reverse

    @ensonilanlar = Advert.all.last(4).reverse

    @acililanlar = Advert.where(:urgent => true).order('created_at DESC').last(7)

    @gununilanlari = Advert.where(:opportunity => true).order('created_at DESC').last(8)

    @mostpopular = []

    popularList = ViewedAdvertCount.group(:advert_id).count.first(6)

    popularList.each do |id, count|
      @mostpopular << Advert.find(id)
    end

  end

 
  
  def mesajSil
    
    
    
  end
  
  def aramasonuclari
    
    
  end
  
 
    
  
  
def mesajPost
  

    username = params[:username]
    topic = params[:topic]
    text = params[:text]
    user = User.find_by_username(username)
    yenimesaj = Message.new(:from => current_user, :to => user,:topic => topic,:text => text)

    if yenimesaj.save
      respond_to do |format|
        msg = { :check => true}
        format.json  { render :json => msg }
      end
    else
      respond_to do |format|
        msg = { :check => false}
        format.json  { render :json => msg }
      end
    end
  end
  
  def mesajlarim
    
    if !current_user
      
      raise ActionController::RoutingError.new('Not Found')
      
    end
    
    
  end


end
