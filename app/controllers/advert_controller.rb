class AdvertController < ApplicationController

  layout false

  helper_method :current_user
  
  def ikinciel
    
    advert_name = params[:advert_name]
    id = advert_name.split('-')[-1]
    @advert = Advert.where(:id => id, :advertable_type => 'Secondhand')[0]
    
    if !@advert
      redirect_to '/404'
      return
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
      redirect_to '/404'
    end
    
    name = @advert.name
    link = name.parameterize + '-' + id
    if link != advert_name
        redirect_to '/dersnotu/' + link
    end
    
    
    
    
    
  end
  
  def ilanver
    
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
      params[:images].each do |image|   
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
    elsif kategori=="dersnotu"
      @title="Ders Notları"
    elsif kategori=="evarkadasi"
      @title="Ev Arkadaşı İlanları"
    elsif kategori=="ozelders"
      @title="Özel Ders İlanları"
    elsif kategori==nil
      @title="İkinci El İlanlar"
    else
      redirect_to "/kategoriler"
    end

    subkategori=params[:subkategori]
    if subkategori=="beyazesya"
      @title="Beyaz Eşya"
    elsif subkategori=="evdekorasyonu"
      @title="Ev Dekorasyonu"
    elsif subkategori=="muzikaletleri"
      @title="Müzik Aletleri"
    elsif subkategori=="elektronik"
      @title="Elektronik"
    elsif subkategori=="kirtasiye"
      @title="Kırtasiye"
    elsif subkategori=="mutfakesyalari"
      @title="Mutfak Eşyaları"
    elsif subkategori=="diger"
      @title="Diğer"
    end
  end

  def firsatlar
    if params[:acililanlar]!=nil
      @title="Acil İlanlar"
      @active = 0
      @ilanlar=[]
    elsif params[:gununfirsatlari]!=nil
      @title="Günün Fırsatları"
      @active = 1
      @ilanlar=[]
    elsif params[:ensonilanlar]!=nil
      @title="En Son İlanlar"
      @active = 2
      @ilanlar=[]
    elsif params[:enpopulerilanlar]!=nil
      @title="En Popüler İlanlar"
      @active = 3
      @ilanlar=[]
    elsif params[:fiyatidusenler]!=nil
      @title="Fiyatı Düşenler"
      @active = 4
      @ilanlar=[]
    elsif params[:enguvenilirsaticilar]!=nil
      @title="En Güvenilir Satıcılar"
      @active = 5
      @ilanlar=[]
    elsif params[:enyakindakisaticilar]!=nil
      @enyakindakisaticilar=true
      @title="En Yakında Olan Satıcılar"
      @ilanlar=[]
    else
      @title="Acil İlanlar"
      @active = 0
      @ilanlar=[]
    end
  end

end
