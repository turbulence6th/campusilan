class IndexController < ApplicationController

  layout false

  helper_method :current_user
  
  def index

    @ensonikinciel = ensonikinciel.limit(4)
    @ensonevarkadasi = ensonevarkadasi.limit(4)
    @ensonozelders = ensonozelders.limit(4)
    @ensonilanlar = ensonilanlar.limit(4)
    @acililanlar = acililanlar.limit(8)
    @gununilanlari = gununilanlari.limit(8)
    @mostpopular = mostpopular.limit(10)
    @bizimsectiklerimiz = bizimsectiklerimiz.limit(10)
    
    @enguvenilirikinciel = enguvenilirikinciel.limit(6)
    @enguvenilirevarkadasi = enguvenilirevarkadasi.limit(6)
    @enguvenilirozelders = enguvenilirozelders.limit(6)

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
    
    if params[:kategori] == "ikinciel"
      
      @adverts = Advert.select("adverts.*").from("adverts, secondhands")
        .where("adverts.advertable_type=? AND adverts.advertable_id=secondhands.id", "Secondhand")
    
      if params[:marka] && params[:marka] != ""
        @adverts = @adverts.where("secondhands.brand LIKE ?", "%" + params[:marka] + "%")
      end
      
      if params[:color] && params[:color] != "" && params[:color] != "hepsi"
        @adverts = @adverts.where(:secondhands => {:color => params[:color]})
      end
      
    else
      
      @adverts = Advert.all
      
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

end
