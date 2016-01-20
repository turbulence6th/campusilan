class AdvertController < ApplicationController

  layout false

  helper_method :current_user
  def vote

    if current_user

      advert = Advert.find_by(:id => params[:advert])
      point = params[:point]

      if Vote.where(:user => current_user, :advert => advert).present?

        vote = Vote.find_by(:user => current_user, :advert => advert)
      vote.point = point

      else

        vote = Vote.new(:user => current_user, :advert => advert, :point => point)

      end

      if vote.save

        respond_to do |format|
          msg = { :check => true }
          format.json  { render :json => msg }
        end

      else

        respond_to do |format|
          msg = { :check => false }
          format.json  { render :json => msg }
        end

      end

    end

  end

  def votedelete

    if current_user

      advert = Advert.find_by(:id => params[:advert])

      if Vote.where(:user => current_user, :advert => advert).present?

        vote = Vote.find_by(:user => current_user, :advert => advert)
        vote.destroy

        respond_to do |format|
          msg = { :check => true }
          format.json  { render :json => msg }
        end

      else

        respond_to do |format|
          msg = { :check => false }
          format.json  { render :json => msg }
        end

      end

    end

  end

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

    if current_user
      vote = Vote.find_by(:user => current_user, :advert => @advert)
      if vote
        @vote = vote.point
      else
        @vote = 0
      end
    end

    @looked = looked(@advert).limit(5)

    @similar = Advert.joins('JOIN secondhands ON adverts.advertable_id=secondhands.id')
      .where(:advertable_type => 'Secondhand',:secondhands => { :category => @advertable.read_attribute(:category) })
      .where.not(:id => @advert.id).sample(3)

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
    
    if current_user
      vote = Vote.find_by(:user => current_user, :advert => @advert)
      if vote
        @vote = vote.point
      else
        @vote = 0
      end
    end

    @looked = looked(@advert).limit(5)

    @similar = Advert.where(:advertable_type => 'Homemate').where.not(:id => @advert.id).offset(Homemate.count).limit(4)

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
    
    if current_user
      vote = Vote.find_by(:user => current_user, :advert => @advert)
      if vote
        @vote = vote.point
      else
        @vote = 0
      end
    end

    @looked = looked(@advert).limit(5)

    @similar = Advert.joins('JOIN secondhands ON adverts.advertable_id=secondhands.id').where(:advertable_type => 'Secondhand',:secondhands => { :category => @advertable.read_attribute(:category) }).where.not(:id => @advert.id).sample(4)

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

      advertableparam = params.require(:advert).require(:secondhand).permit(
      :category, :color, :brand, :usage, :warranty)

    elsif params[:advert_type] == 'homemate'

      advertableparam = params.require(:advert).require(:homemate).permit(
      :state, :city, :demand, :sleep, :friend, :smoke, :department, :music)

    elsif param[:advert_type] == 'privatelesson'

      advertableparam = params.require(:advert).require(:privatelesson).permit(
      :kind, :lecture, :state, :city, :location)
      
    end

    advertParam = params.require(:advert).permit(:name, :price, :explication)
    id = params.require(:advert).permit(:id)[:id]

    advert = Advert.find(id)
    if !current_user || (advert.user!=current_user && current_user.role!='admin') || advert.advertable_type!='Secondhand'
      raise ActionController::RoutingError.new('Not Found')
    else
      advert.update_attributes(advertParam)
      advert.advertable.update_attributes(advertableparam)
      if params[:images]
        params[:images].reverse.each do |image|
          image = Image.new(:imagefile => image)
          advert.images << image
        end
      end
      redirect_to URI(request.referer).path
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
  
  def newAdvertPost
    
    if params[:advert_type] == 'secondhand'
      
      @advertable = Secondhand.new(params.require(:advert).require(:advertable).permit(
      :category, :color, :brand, :usage, :warranty))
     
    elsif params[:advert_type] == 'homemate'
      
      @advertable = Homemate.new(params.require(:advert).require(:advertable).permit(
      :state, :city, :demand, :sleep, :friend, :smoke, :department, :music))
      
    elsif params[:advert_type] == 'privatelesson'
      
      @advertable = Privatelesson.new(params.require(:advert).require(:advertable).permit(:state, :city,
      :kind, :lecture, :location))
      
    end
     
    @advert = Advert.new(params.require(:advert).permit(:name, :price, :explication))
    @advert.advertable = @advertable
    @advert.user = current_user
    @advert.active = true
    @advert.verified = false
    @advert.verified = true if current_user.role=='admin'

    @advert.urgent = false
    @advert.opportunity = false
    @advert.ours = false

    if params[:images]

      images = params[:images].reverse

      @image = Image.new(:imagefile => images.shift)
      @advert.images << @image
      @advert.image = @image

      images.each do |image|
        @image = Image.new(:imagefile => image)
        @advert.images << @image
      end
    end

    if @advert.save
    # send mail
    end

    redirect_to "/"
  end


  def kategoriler
    kategori=params[:kategori]
    if kategori=="ikincielilan"

      @adverts = Advert.available.select('adverts.*').from('adverts, secondhands')
          .where("adverts.advertable_type=? AND adverts.advertable_id=secondhands.id", "Secondhand")

      subkategori=params[:subkategori]

      if subkategori
        @adverts = @adverts.where(:secondhands => {:category => Secondhand.categories[subkategori]})
      end

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
      elsif subkategori=="vasita"
        @title="Vasıta"
      elsif subkategori=="giyim"
        @title="Giyim"
      elsif subkategori=="dersnotu"
        @title="Ders Notları"
      elsif subkategori=="diger"
        @title="Diğer"
      else
        @title="İkinci El İlanlar"
      end

    elsif kategori=="evarkadasi"

      @title="Ev Arkadaşı İlanları"
      @adverts = Advert.available.where(:advertable_type => 'Homemate')

    elsif kategori=="ozelders"

      @adverts = Advert.available.select('adverts.*').from('adverts, privatelessons')
          .where("adverts.advertable_type=? AND adverts.advertable_id=privatelessons.id", "Privatelesson")

      subkategori=params[:subkategori]

      if subkategori
        @adverts = @adverts.where(:privatelessons => {:lecture => Privatelesson.lectures[subkategori]})
      end

      if subkategori=="matematik"
        @title="Matematik"
      elsif subkategori=="fizik"
        @title="Fizik"
      elsif subkategori=="kimya"
        @title="Kimya"
      elsif subkategori=="biyoloji"
        @title="Biyoloji"
      elsif subkategori=="genelmuhendislik"
        @title="Genel Mühendislik"
      elsif subkategori=="genelegitimbilimleri"
        @title="Genel Eğitim Bilimleri"
      else
        @title="Özel Ders İlanları"
      end

    elsif kategori==nil
      @title="İkinci El İlanlar"
      @adverts = Advert.available.select('adverts.*').from('adverts, secondhands')
          .where("adverts.advertable_type=? AND adverts.advertable_id=secondhands.id", "Secondhand")
    else
      redirect_to "/kategoriler"
    end

    @adverts = @adverts.order("created_at DESC").paginate(:page => params[:page], :per_page => 18)

    @gununilanlari = gununilanlari.limit(8)

    @mostpopular = mostpopular.limit(8)

  end

  def firsatlar
    if params[:acililanlar]!=nil
      @title="Acil İlanlar"
      @active = 0
      @adverts = acililanlar.paginate(:page => params[:page], :per_page => 18)
    elsif params[:gununfirsatlari]!=nil
      @title="Günün Fırsatları"
      @active = 1
      @adverts = gununilanlari.paginate(:page => params[:page], :per_page => 18)
    elsif params[:ensonilanlar]!=nil
      @title="En Son İlanlar"
      @active = 2
      @adverts = ensonilanlar.paginate(:page => params[:page], :per_page => 18)
    elsif params[:enpopulerilanlar]!=nil
      @title="En Popüler İlanlar"
      @active = 3
      @adverts = mostpopular.paginate(:page => params[:page], :per_page => 18)
    elsif params[:fiyatidusenler]!=nil
      @title="Fiyatı Düşenler"
      @active = 4
      @adverts = []
    elsif params[:enguvenilirsaticilar]!=nil
      @title="En Güvenilir Satıcılar"
      @active = 5
      @users = enguvenilir.paginate(:page => params[:page], :per_page => 18)
      @adverts = []
    elsif params[:kendiuniversitemdekiler]!=nil
      @title="Kendi Üniversitemdeki İlanlar"
      @active = 6
      if current_user
        @adverts = kendiuniversitem.paginate(:page => params[:page], :per_page => 18)
      else
        @advert = []
      end

    else
      @title="Acil İlanlar"
      @active = 0
      @adverts = acililanlar.paginate(:page => params[:page], :per_page => 18)
    end

    @bizimsectiklerimiz = bizimsectiklerimiz.limit(10)

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
