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
    
    @enguvenilirikinciel = enguvenilirikinciel[0..5]
    @enguvenilirevarkadasi = enguvenilirevarkadasi[0..5]
    @enguvenilirozelders = enguvenilirozelders[0..5]

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
    
     if params[:kategori] == 'hepsi'
     
      @adverts = Advert.available.all
      
   
   
    
    elsif params[:kategori] == "ikinciel"
      
      @adverts = Advert.available.select("adverts.*").from("adverts, secondhands")
        .where("adverts.advertable_type=? AND adverts.advertable_id=secondhands.id", "Secondhand")
      
      altkategori = params[:altkategori]
      
      if altkategori && altkategori != "" && altkategori != "hepsi"
        @adverts = @adverts.where(:secondhands => {:category => altkategori})
      end    
        
      if params[:marka] && params[:marka] != ""
        @adverts = @adverts.where("secondhands.brand LIKE ?", "%" + params[:marka] + "%")
      end
      
      if params[:color] && params[:color] != "" && params[:color] != "hepsi"
        @adverts = @adverts.where(:secondhands => {:color => params[:color]})
      end
      
    elsif params[:kategori] == "evarkadasi"
      
      @adverts = Advert.select("adverts.*").from("adverts, homemates")
        .where("adverts.advertable_type=? AND adverts.advertable_id=homemates.id", "Homemate")
        
      if params[:sehir] && params[:sehir] != ""
        @adverts = @adverts.where("homemates.city LIKE ?", "%" + params[:sehir] + "%")
      end
      
      if params[:semt] && params[:semt] != ""
        @adverts = @adverts.where("homemates.state LIKE ?", "%" + params[:semt] + "%")
      end
      
      if params[:demand] && params[:demand] != ""
        @adverts = @adverts.where(:homemates => {:demand => params[:demand]})
      end
      
      if params[:sleep] && params[:sleep] != "" && params[:sleep] != "hepsi"
        @adverts = @adverts.where(:homemates => {:sleep => params[:sleep]})
      end
      
      if params[:friend] && params[:friend] != "" && params[:friend] != "hepsi"
        @adverts = @adverts.where(:homemates => {:friend => params[:friend]})
      end
      
      if params[:smoke] && params[:smoke] != "" && params[:smoke] != "hepsi"
        @adverts = @adverts.where(:homemates => {:smoke => params[:smoke]})
      end
      
      if params[:department] && params[:department] != "" && params[:department] != "hepsi"
        @adverts = @adverts.where(:homemates => {:department => params[:department]})
      end
      
      if params[:music] && params[:music] != "" && params[:music] != "hepsi"
        @adverts = @adverts.where(:homemates => {:music => params[:music]})
      end
      
     elsif params[:kategori] == "ozelders"
       
      @adverts = Advert.select("adverts.*").from("adverts, privatelessons")
        .where("adverts.advertable_type=? AND adverts.advertable_id=privatelessons.id", "Privatelesson")
        
      if params[:sehir] && params[:sehir] != ""
        @adverts = @adverts.where("privatelessons.city LIKE ?", "%" + params[:sehir] + "%")
      end
      
      if params[:semt] && params[:semt] != ""
        @adverts = @adverts.where("privatelessons.state LIKE ?", "%" + params[:semt] + "%")
      end
      
      if params[:altkategori] && params[:altkategori] != "" && params[:altkategori] != "hepsi"
        @adverts = @adverts.where(:privatelessons => {:lecture => params[:altkategori]})
      end
      
      if params[:kind] && params[:kind] != "" && params[:kind] != "hepsi"
        @adverts = @adverts.where(:privatelessons => {:kind => params[:kind]})
      end
      
      if params[:location] && params[:location] != "" && params[:location] != "hepsi"
        @adverts = @adverts.where(:privatelessons => {:location => params[:location]})
      end
          
     else 
        
      @adverts = Advert.all
           
    end
    
    
    
    if params[:aramakismi] && params[:aramakismi]!=""   
      @adverts = @adverts.where("adverts.name LIKE ?", "%" + params[:aramakismi] + "%") 
    end
    
    if params[:taban] && params[:taban] != ""
      @adverts = @adverts.where("adverts.price >= ?", params[:taban].to_i)
    end
    
    if params[:tavan] && params[:tavan] != ""
      @adverts = @adverts.where("adverts.price <= ?", params[:tavan].to_i)
    end
    
    if params[:acililan] == "1"
      @adverts = @adverts & acililanlar
    end
    
    
    @adverts.each do |adv|
      puts adv.name
    end
    
  
    
    

  end
  
  def universiteler

   if params[:universities] == nil
     
     @adverts = Advert.available.joins(:user).where(:users => {university_id: topUniversities[0]['id']})
   
     @title = topUniversities[0]['name']
       
      
   else
     
     @adverts = Advert.available.joins(:user).where(:users => {university_id: params[:universities]})
   
     @title = University.find(params[:universities]).name
    
     
   end


  end
  
  def favorilerim
    
    if current_user!= nil
      
      @favouriteadverts = Advert.available.select('adverts.*').from('adverts, users, favourite_adverts')
        .where('adverts.id=favourite_adverts.advert_id AND users.id=favourite_adverts.user_id AND users.id=?', current_user.id)
        .order('favourite_adverts.created_at DESC').limit(9).paginate(:page => params[:page], :per_page => 1)
      
    else 
      
      raise ActionController::RoutingError.new('Not Found')  
      
      
    end
    
    
  end
  
  def ilanlarim
    
    if current_user!= nil
    
    @lastadverts = current_user.adverts.paginate(:page => params[:page], :per_page => 8)
    
    
    else
      
       raise ActionController::RoutingError.new('Not Found')  
    
    end
    
  end

  
  def incelediklerim
    
    if current_user!= nil
    
    @incelediklerim = Advert.available.select('adverts.*').from('adverts, users, viewed_adverts')
        .where('adverts.id=viewed_adverts.advert_id AND users.id=viewed_adverts.user_id AND users.id=?', current_user.id)
        .order('viewed_adverts.created_at DESC')
        
     else
       
        raise ActionController::RoutingError.new('Not Found')  
       
       
     end  
    
  end

end
