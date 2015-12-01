class AdvertController < ApplicationController

  layout false

  helper_method :current_user
  
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
      @ilanlar=[]
    elsif params[:gununfirsatlari]!=nil
      @title="Günün Fırsatları"
      @ilanlar=[]
    elsif params[:ensonilanlar]!=nil
      @title="En Son İlanlar"
      @ilanlar=[]
    elsif params[:enpopulerilanlar]!=nil
      @title="En Popüler İlanlar"
      @ilanlar=[]
    elsif params[:fiyatidusenler]!=nil
      @title="Fiyatı Düşenler"
      @ilanlar=[]
    elsif params[:enguvenilirsaticilar]!=nil
      @title="En Güvenilir Satıcılar"
      @ilanlar=[]
    elsif params[:enyakindakisaticilar]!=nil
      @enyakindakisaticilar=true
      @title="En Yakında Olan Satıcılar"
      @ilanlar=[]
    else
      @title="Acil İlanlar"
      @ilanlar=[]
    end
  end

end
