class AdvertController < ApplicationController

  layout false

  helper_method :current_user
  def ikinciel

    advert_name = params[:advert_name]
    id = advert_name.split('-')[-1]
    @advert = Advert.find_by(:id => id, :advertable_type => 'Secondhand', :verified => true)

    if !@advert
      raise ActionController::RoutingError.new('Not Found')
    end

    if @advert.href != '/ikinciel/' + advert_name
      redirect_to '/ikinciel/' + link
    end

    if current_user
      @advert.viewed_adverts << ViewedAdvert.new(:user => current_user)
    end

    @advert.viewed_advert_counts << ViewedAdvertCount.new(:ip => request.remote_ip)

    @advertable = @advert.advertable
    @advert_user = @advert.user
    @images = @advert.images

    @looked = Advert.select('a2.*').from('adverts a,users u, viewed_adverts v, adverts a2, viewed_adverts v2')
      .where('a.id=? AND v.user_id = u.id AND v.advert_id = a.id AND a.id!=a2.id AND v2.user_id = u.id AND v2.advert_id = a2.id', @advert.id).group('a2.id').order('count(a2.id)')[0..4]
      
    @similar = Advert.joins('JOIN secondhands ON adverts.advertable_id=secondhands.id').where(:advertable_type => 'Secondhand',:secondhands => { :category => @advertable.read_attribute(:category) }).where.not(:id => @advert.id).sample(4)
    
  end

  def evarkadasi
    advert_name = params[:advert_name]
    id = advert_name.split('-')[-1]
    @advert = Advert.find_by(:id => id, :advertable_type => 'Homemate', :verified => true)

    if !@advert
      raise ActionController::RoutingError.new('Not Found')
    end

    if @advert.href != '/evarkadasi/' + advert_name
      redirect_to '/evarkadasi/' + link
    end

    if current_user
      @advert.viewed_adverts << ViewedAdvert.new(:user => current_user)
    end

    @advert.viewed_advert_counts << ViewedAdvertCount.new(:ip => request.remote_ip)

    @advertable = @advert.advertable
    @advert_user = @advert.user
    @images = @advert.images

  end

  def ozelders
    advert_name = params[:advert_name]
    id = advert_name.split('-')[-1]
    @advert = Advert.find_by(:id => id, :advertable_type => 'Privatelesson', :verified => true)

    if !@advert
      raise ActionController::RoutingError.new('Not Found')
    end

    if @advert.href != '/ozelders/' + advert_name
      redirect_to '/ozelders/' + link
    end

    if current_user
      @advert.viewed_adverts << ViewedAdvert.new(:user => current_user)
    end

    @advert.viewed_advert_counts << ViewedAdvertCount.new(:ip => request.remote_ip)

    @advertable = @advert.advertable
    @advert_user = @advert.user
    @images = @advert.images

  end

  def ilanver

    if !current_user
      redirect_to "/girisyap"
    end

  end

  def ilanguncelle

    advert_name = params[:advert_name]
    id = advert_name.split('-')[-1]
    @advert = Advert.find_by(:id => id, :verified => true)

    if !@advert

      raise ActionController::RoutingError.new('Not Found')

    elsif !current_user || (@advert.user!=current_user && current_user.role!='admin')

      raise ActionController::RoutingError.new('Not Found')

    end

    name = @advert.name
    link = name.parameterize + '-' + id
    if link != advert_name
      redirect_to '/ilanguncelle/' + link
    end

    @images = @advert.images

  end

  def ilanguncellePost

    if params[:advert_type] == 'secondhand'

      secondhandParam = params.require(:advert).require(:secondhand).permit(
      :category, :color, :brand, :usage, :warranty)
      advertParam = params.require(:advert).permit(:name, :price, :explication)
      id = params.require(:advert).permit(:id)[:id]

      advert = Advert.find(id)
      if !current_user || (advert.user!=current_user && current_user.role!='admin') || advert.advertable_type!='Secondhand'
        raise ActionController::RoutingError.new('Not Found')
      else
        advert.update_attributes(advertParam)
        advert.advertable.update_attributes(secondhandParam)
        if params[:images]
          params[:images].reverse.each do |image|
            image = Image.new(:imagefile => image)
            advert.images << image
          end
        end
        redirect_to URI(request.referer).path
      end

    elsif params[:advert_type] == 'homemate'

      homemateParam = params.require(:advert).require(:homemate).permit(
      :state, :city, :demand)
      advertParam = params.require(:advert).permit(:name, :price, :explication)
      id = params.require(:advert).permit(:id)[:id]

      advert = Advert.find(id)
      if !current_user || (advert.user!=current_user && current_user.role!='admin') || advert.advertable_type!='Homemate'
        raise ActionController::RoutingError.new('Not Found')
      else
        advert.update_attributes(advertParam)
        advert.advertable.update_attributes(homemateParam)
        if params[:images]
          params[:images].reverse.each do |image|
            image = Image.new(:imagefile => image)
            advert.images << image
          end
        end
        redirect_to URI(request.referer).path
      end

    end

  end

  def deleteimage

    advert = Advert.find(params[:advert])
    image = Image.find(params[:image])

    if !current_user || (advert.user!=current_user && current_user.role!='admin')

      respond_to do |format|
        msg = {:check => false}
        format.json { render :json => msg}

      end
    elsif advert.images.include? image

      image.destroy

      respond_to do |format|
        msg = {:check => true}
        format.json { render :json => msg}

      end

    else

      respond_to do |format|
        msg = {:check => false}
        format.json { render :json => msg}

      end

    end

  end

  def secondhandPost
    @secondhand = Secondhand.new(params.require(:advert).require(:advertable).permit(
      :category, :color, :brand, :usage, :warranty))
    @advert = Advert.new(params.require(:advert).permit(:name, :price, :explication))
    @advert.advertable = @secondhand
    @advert.user = current_user
    @advert.active = true
    @advert.verified = false
    @advert.verified = true if current_user.role=='admin'
    
    @advert.urgent = false
    @advert.opportunity = false

    if params[:images]
      params[:images].reverse.each do |image|
        @image = Image.new(:imagefile => image)
        @advert.images << @image
      end
    end

    @advert.save
    redirect_to "/"
  end

  def privatelessonPost

    @privatelesson = Privatelesson.new(params.require(:advert).require(:advertable).permit(:state, :city,
      :kind, :lecture, :location))
    @advert = Advert.new(params.require(:advert).permit(:name, :price, :explication))
    @advert.advertable = @privatelesson
    @advert.user = current_user
    @advert.active = true
    @advert.verified = false
    @advert.verified = true if current_user.role=='admin'
    @advert.urgent = false
    @advert.opportunity = false

    if params[:images]
      params[:images].reverse.each do |image|
        @image = Image.new(:imagefile => image)
        @advert.images << @image
      end
    end

    puts @advert.valid?
    puts @privatelesson.valid?

    @advert.save
    redirect_to "/"

  end

  def homematePost

    @homemate = Homemate.new(params.require(:advert).require(:advertable).permit(
      :state, :city, :demand))
    @advert = Advert.new(params.require(:advert).permit(:name, :price, :explication))
    @advert.advertable = @homemate
    @advert.user = current_user
    @advert.active = true
    @advert.verified = false
    @advert.verified = true if current_user.role=='admin'
    
    @advert.urgent = false
    @advert.opportunity = false

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

      subkategori=params[:subkategori]
      if subkategori=="beyazesya"
        @title="Beyaz Eşya"
        @adverts = Advert.available.select('adverts.*').from('adverts, secondhands')
          .where("adverts.advertable_type='Secondhand' AND adverts.advertable_id=secondhands.id AND secondhands.category=0").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="evdekorasyonu"
        @title="Ev Dekorasyonu"
        @adverts = Advert.available.select('adverts.*').from('adverts, secondhands')
          .where("adverts.advertable_type='Secondhand' AND adverts.advertable_id=secondhands.id AND secondhands.category=1").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="muzikaletleri"
        @title="Müzik Aletleri"
        @adverts = Advert.available.select('adverts.*').from('adverts, secondhands')
          .where("adverts.advertable_type='Secondhand' AND adverts.advertable_id=secondhands.id AND secondhands.category=2").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="elektronik"
        @title="Elektronik"
        @adverts = Advert.available.select('adverts.*').from('adverts, secondhands')
          .where("adverts.advertable_type='Secondhand' AND adverts.advertable_id=secondhands.id AND secondhands.category=3").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="kirtasiye"
        @title="Kırtasiye"
        @adverts = Advert.available.select('adverts.*').from('adverts, secondhands')
          .where("adverts.advertable_type='Secondhand' AND adverts.advertable_id=secondhands.id AND secondhands.category=4").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="mutfakesyalari"
        @title="Mutfak Eşyaları"
        @adverts = Advert.available.select('adverts.*').from('adverts, secondhands')
          .where("adverts.advertable_type='Secondhand' AND adverts.advertable_id=secondhands.id AND secondhands.category=5").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="vasita"
        @title="Vasıta"
        @adverts = Advert.available.select('adverts.*').from('adverts, secondhands')
          .where("adverts.advertable_type='Secondhand' AND adverts.advertable_id=secondhands.id AND secondhands.category=6").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="giyim"
        @title="Giyim"
        @adverts = Advert.available.select('adverts.*').from('adverts, secondhands')
          .where("adverts.advertable_type='Secondhand' AND adverts.advertable_id=secondhands.id AND secondhands.category=7").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="dersnotu"
        @title="Ders Notları"
        @adverts = Advert.available.select('adverts.*').from('adverts, secondhands')
          .where("adverts.advertable_type='Secondhand' AND adverts.advertable_id=secondhands.id AND secondhands.category=8").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="diger"
        @title="Diğer"
        @adverts = Advert.available.select('adverts.*').from('adverts, secondhands')
          .where("adverts.advertable_type='Secondhand' AND adverts.advertable_id=secondhands.id AND secondhands.category=9").paginate(:page => params[:page], :per_page => 18).reverse
      
      else
        
        @title="İkinci El İlanlar"
        @adverts = Advert.available.where(:advertable_type => 'Secondhand').paginate(:page => params[:page], :per_page => 18).reverse
        
      end

    elsif kategori=="evarkadasi"
      @title="Ev Arkadaşı İlanları"
      @adverts = Advert.available.where(:advertable_type => 'Homemate').paginate(:page => params[:page], :per_page => 18).reverse

    elsif kategori=="ozelders"
      
      subkategori=params[:subkategori]
      if subkategori=="matematik"
        @title="Matematik"
        @adverts = Advert.available.select('adverts.*').from('adverts, privatelessons')
          .where("adverts.advertable_type='Privatelesson' AND adverts.advertable_id=privatelessons.id AND privatelessons.lecture=0").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="fizik"
        @title="Fizik"
        @adverts = Advert.available.select('adverts.*').from('adverts, privatelessons')
          .where("adverts.advertable_type='Privatelesson' AND adverts.advertable_id=privatelessons.id AND privatelessons.lecture=1").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="kimya"
        @title="Kimya"
        @adverts = Advert.available.select('adverts.*').from('adverts, privatelessons')
          .where("adverts.advertable_type='Privatelesson' AND adverts.advertable_id=privatelessons.id AND privatelessons.lecture=2").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="biyoloji"
        @title="Biyoloji"
        @adverts = Advert.available.select('adverts.*').from('adverts, privatelessons')
          .where("adverts.advertable_type='Privatelesson' AND adverts.advertable_id=privatelessons.id AND privatelessons.lecture=3").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="genelmuhendislik"
        @title="Genel Mühendislik"
        @adverts = Advert.available.select('adverts.*').from('adverts, privatelessons')
          .where("adverts.advertable_type='Privatelesson' AND adverts.advertable_id=privatelessons.id AND privatelessons.lecture=4").paginate(:page => params[:page], :per_page => 18).reverse
      elsif subkategori=="genelegitimbilimleri"
        @title="Genel Eğitim Bilimleri"
        @adverts = Advert.available.select('adverts.*').from('adverts, privatelessons')
          .where("adverts.advertable_type='Privatelesson' AND adverts.advertable_id=privatelessons.id AND privatelessons.lecture=5").paginate(:page => params[:page], :per_page => 18).reverse
          
      else
        
        @title="Özel Ders İlanları"
        @adverts = Advert.available.where(:advertable_type => 'Privatelesson').paginate(:page => params[:page], :per_page => 18).reverse

      end

    elsif kategori==nil
      @title="İkinci El İlanlar"
      @adverts = Advert.available.where(:advertable_type => 'Secondhand').paginate(:page => params[:page], :per_page => 18).reverse
    else
      redirect_to "/kategoriler"
    end
    
    @gununilanlari = Advert.available.where(:opportunity => true).order('created_at DESC').last(8)
    
    @mostpopular = Advert.select('a.*').from('adverts a, viewed_advert_counts v')
      .where('a.id=v.advert_id and verified=true and active=true').group('a.id').order('count(*) desc')

  end

  def firsatlar
    if params[:acililanlar]!=nil
      @title="Acil İlanlar"
      @active = 0
      @adverts = Advert.available.where(:urgent => true).order('created_at DESC').paginate(:page => params[:page], :per_page => 18)
    elsif params[:gununfirsatlari]!=nil
      @title="Günün Fırsatları"
      @active = 1
      @adverts = Advert.available.where(:opportunity => true).order('created_at DESC').paginate(:page => params[:page], :per_page => 18)
    elsif params[:ensonilanlar]!=nil
      @title="En Son İlanlar"
      @active = 2
      @adverts = Advert.available.order('created_at DESC').paginate(:page => params[:page], :per_page => 18)
    elsif params[:enpopulerilanlar]!=nil
      @title="En Popüler İlanlar"
      @active = 3
      @adverts = Advert.select('a.*').from('adverts a, viewed_advert_counts v')
      .where('a.id=v.advert_id and verified=true and active=true').group('a.id').order('count(*) desc').paginate(:page => params[:page], :per_page => 18)
    elsif params[:fiyatidusenler]!=nil
      @title="Fiyatı Düşenler"
      @active = 4
      @adverts = []
    elsif params[:enguvenilirsaticilar]!=nil
      @title="En Güvenilir Satıcılar"
      @active = 5
      @adverts = []
    elsif params[:kendiuniversitemdekiler]!=nil
      @title="Kendi Üniversitemdeki İlanlar"
      @active = 6
      if current_user
        @adverts = Advert.select('a.*').from('adverts a, users u1, users u2')
          .where('u1.id=? and u1.university_id=u2.university_id and a.user_id=u2.id and a.verified=true and a.active=true', current_user.id).paginate(:page => params[:page], :per_page => 18)
      end
      
    else
     @title="Acil İlanlar"
      @active = 0
      @adverts = Advert.available.where(:urgent => true).order('created_at DESC').paginate(:page => params[:page], :per_page => 18)
    end
    
    @mostpopular = Advert.select('a.*').from('adverts a, viewed_advert_counts v')
      .where('a.id=v.advert_id and verified=true and active=true').group('a.id').order('count(*) desc')
    
    
  end

  def favorilereekle

    advertid = params[:advertid]

    if Advert.available.find(advertid).favourite_adverts << FavouriteAdvert.new(:user => current_user )

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

  def favorilerdenkaldir

    advertid = params[:advertid]

    a = Advert.available.find(advertid).favourite_adverts.find_by(:user => current_user)
    if a

      a.destroy
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

end
