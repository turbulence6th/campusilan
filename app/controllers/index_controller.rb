class IndexController < ApplicationController

  layout false

  helper_method :current_user
  
  def index

    @ensonikinciel = ensonikinciel[0..3]
    @ensonevarkadasi = ensonevarkadasi[0..3]
    @ensonozelders = ensonozelders[0..3]
    @ensonilanlar = ensonilanlar[0..4]
    @acililanlar = acililanlar[0..7]
    @gununilanlari = gununilanlari[0..7]
    @mostpopular = mostpopular[0..9]
    @bizimsectiklerimiz = bizimsectiklerimiz[0..9]

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
    
   
   

   if params[:universities] == nil
     
     @adverts = Advert.available.joins(:user).where(:users => {university: topUniversities[0]['id']})
   
     @title = topUniversities[0]['name']
       
      
   else
     
     @adverts = Advert.available.joins(:user).where(:users => {university: params[:universities]})
   
     @title = University.find(params[:universities]).name
    
     
   end
   
   
   
   
   
   
  
  end

end
