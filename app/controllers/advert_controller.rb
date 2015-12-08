class AdvertController < ApplicationController

  layout false

  helper_method :current_user
  
  def ikinciel
    
    advert_name = params[:advert_name]
    id = advert_name.split('-')[-1]
    @advert = Advert.where(:id => id, :advertable_type => 'Secondhand')[0]
    
    if !@advert
      raise ActionController::RoutingError.new('Not Found')
    end
    
    name = @advert.name
    link = name.parameterize + '-' + id
    if link != advert_name
        redirect_to '/ikinciel/' + link
    end
    
    if current_user
      ViewedAdvert.create(:user => current_user, :advert => @advert)
    end
    
    ViewedAdvertCount.create(:ip => request.remote_ip, :advert => @advert)
    
    @advertable = @advert.advertable
    @advert_user = @advert.user
    @images = @advert.images
    
  end
  
  def dersnotu
    advert_name = params[:advert_name]
    id = advert_name.split('-')[-1]
    @advert = Advert.where(:id => id, :advertable_type => 'Lecturenote')[0]
    
    if !@advert
      raise ActionController::RoutingError.new('Not Found')
    end
    
    name = @advert.name
    link = name.parameterize + '-' + id
    if link != advert_name
        redirect_to '/dersnotu/' + link
    end
    
    
    
    
    
  end
  
  def ilanver
    
    if !current_user
      redirect_to "/girisyap"
    end
    
    @advert = Advert.new 
    
  end
  
  def secondhandPost
    @secondhand = Secondhand.new(params.require(:advert).require(:advertable).permit(
      :category, :color, :brand, :usage, :warranty))
    @advert = Advert.new(params.require(:advert).permit(:name, :price, :explication))
    @advert.advertable = @secondhand
    @advert.user = current_user
    @advert.active = true
    
    if params[:images]
      params[:images].reverse.each do |image|   
        @image = Image.new(:imagefile => image)
        @advert.images << @image
      end
    end   
 
    @advert.save
    redirect_to "/"
  end

  def kategoriler
    kategori=params[:kategori]
    if kategori=="ikincielilan"
      @title="İkinci El İlanlar"
      @adverts = Advert.where(:advertable_type => 'Secondhand').reverse
    elsif kategori=="dersnotu"
      @title="Ders Notları"
      @adverts = Advert.where(:advertable_type => 'Lessonnote').reverse
    elsif kategori=="evarkadasi"
      @title="Ev Arkadaşı İlanları"
      @adverts = Advert.where(:advertable_type => 'Homemate').reverse
    elsif kategori=="ozelders"
      @title="Özel Ders İlanları"
      @adverts = Advert.where(:advertable_type => 'Privatelesson').reverse
    elsif kategori==nil
      @title="İkinci El İlanlar"
      @adverts = Advert.where(:advertable_type => 'Secondhand').reverse
    else
      redirect_to "/kategoriler"
    end

    subkategori=params[:subkategori]
    if subkategori=="beyazesya"
      @title="Beyaz Eşya"
      @adverts = @adverts.select {|adv| adv.advertable.category=='beyazesya'}
    elsif subkategori=="evdekorasyonu"
      @title="Ev Dekorasyonu"
      @adverts = @adverts.select {|adv| adv.advertable.category=='evdekorasyonu'}
    elsif subkategori=="muzikaletleri"
      @title="Müzik Aletleri"
      @adverts = @adverts.select {|adv| adv.advertable.category=='muzikaletleri'}
    elsif subkategori=="elektronik"
      @title="Elektronik"
      @adverts = @adverts.select {|adv| adv.advertable.category=='elektronik'}
    elsif subkategori=="kirtasiye"
      @title="Kırtasiye"
      @adverts = @adverts.select {|adv| adv.advertable.category=='kirtasiye'}
    elsif subkategori=="mutfakesyalari"
      @title="Mutfak Eşyaları"
      @adverts = @adverts.select {|adv| adv.advertable.category=='mutfakesyalari'}
    elsif subkategori=="diger"
      @title="Diğer"
      @adverts = @adverts.select {|adv| adv.advertable.category=='diger'}
    end
  end

  def firsatlar
    if params[:acililanlar]!=nil
      @title="Acil İlanlar"
      @active = 0
      @adverts = Advert.where(:urgent => true).order('created_at DESC')
    elsif params[:gununfirsatlari]!=nil
      @title="Günün Fırsatları"
      @active = 1
      @adverts = []
    elsif params[:ensonilanlar]!=nil
      @title="En Son İlanlar"
      @active = 2
      @adverts = Advert.order('created_at DESC')
    elsif params[:enpopulerilanlar]!=nil
      @title="En Popüler İlanlar"
      @active = 3
      @adverts = []
    
      popularList = ViewedAdvertCount.group(:advert_id).count
      
      popularList.each do |id, count|
        @adverts << Advert.find(id)
      end
    elsif params[:fiyatidusenler]!=nil
      @title="Fiyatı Düşenler"
      @active = 4
      @adverts = []
    elsif params[:enguvenilirsaticilar]!=nil
      @title="En Güvenilir Satıcılar"
      @active = 5
      @adverts = []
    elsif params[:enyakindakisaticilar]!=nil
      @enyakindakisaticilar=true
      @title="En Yakında Olan Satıcılar"
      @active = 6
      @adverts = []
    else
      @title="Acil İlanlar"
      @active = 0
      @adverts = []
    end
  end

end
