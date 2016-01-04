class IndexController < ApplicationController

  layout false

  helper_method :current_user
  
  def index

    @ensonikinciel = Advert.available.where(advertable_type: 'Secondhand').last(4).reverse
    @ensonevarkadasi = Advert.available.where(advertable_type: 'Homemate').last(4).reverse
    @ensonozelders = Advert.available.where(advertable_type: 'Privatelesson').last(4).reverse

    @ensonilanlar = Advert.available.all.last(4).reverse

    @acililanlar = Advert.available.where(:urgent => true).order('created_at DESC').last(7)

    @gununilanlari = Advert.available.where(:opportunity => true).order('created_at DESC').last(8)

    @mostpopular = Advert.select('a.*').from('adverts a, viewed_advert_counts v')
      .where('a.id=v.advert_id and verified=true and active=true').group('a.id').order('count(*) desc')

  end

 

  def aramasonuclari

  end

  def mesajPost

    username = params[:username]
    topic = params[:topic]
    text = params[:text]
    user = User.find_by_username(username)
    yenimesaj = Message.new(:from => current_user, :to => user,:topic => topic,:text => text)

    if user!=current_user && yenimesaj.save
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
    
    @messagetype= params[:messagetype]
    
    if @messagetype== 'gelenmesajlar'
    
    @messages = current_user.tos.valid_to.paginate(:page => params[:page], :per_page => 10)
    
    elsif @messagetype== 'gidenmesajlar'
      
    @messages = current_user.froms.valid_from.paginate(:page => params[:page], :per_page => 10) 
    
    else
      
     @messages = current_user.tos.valid_to.paginate(:page => params[:page], :per_page => 10)  
      
    
    end
    
    
  end

  def mesajSil

    if params[:mesajfromid]!= ""
      
     

    mesajfromid= params[:mesajfromid]
    mesajfrom = Message.find_by(id:mesajfromid,to: current_user)
    mesajfrom.todeleted = true
    mesajfrom.save
    
    elsif  params[:mesajtoid]!= ""
     
    
    mesajtoid= params[:mesajtoid]
    mesajto = Message.find_by(id:mesajtoid,from:  current_user)
    mesajto.fromdeleted = true
    mesajto.save
    
    end
  
     respond_to do |format|
        msg = { :check => true}
        format.json  { render :json => msg }
      end

  end
  
 

  def aramasonuclari

  end
  
  def universiteler
    
   @adverts = Advert.available.joins(:user).where(:users => {university: params[:universities]})
   
   @title = University.find(params[:universities]).name
   
  end

end
