class AdvertController < ApplicationController
  require 'will_paginate/array'
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
      
      puts vote.user.id
      puts vote.advert.id
      puts vote.point

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

  def ilan

    type = request.path.split('/')[1]
    advert_name = params[:advert_name]
    id = advert_name.split('-')[-1]

    if type == 'ikinciel'
      @advert = Advert.find_by(:id => id, :advertable_type => 'Secondhand', :verified => true)
    elsif type == 'evarkadasi'
      @advert = Advert.find_by(:id => id, :advertable_type => 'Homemate', :verified => true)
    elsif type == 'ozelders'
      @advert = Advert.find_by(:id => id, :advertable_type => 'Privatelesson', :verified => true)
    end

    if !@advert
      raise ActionController::RoutingError.new('Not Found')
    end

    if @advert.href != request.path
      redirect_to @advert.href
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

    @looked = Rails.cache.fetch("looked/#{id}", :expires_in => 5.minutes) do
      Advert.available.from('adverts, viewed_advert_counts v1, viewed_advert_counts v2')
        .where('v1.advert_id = ? AND v2.advert_id != v1.advert_id AND v2.ip = v1.ip ' +
          'AND adverts.id = v2.advert_id', @advert.id).group('adverts.id')
          .order('count(adverts) DESC, created_at ASC').take(5)
    end

    if type == 'ikinciel'
      @similar = Rails.cache.fetch("similar/#{id}", :expires_in => 5.minutes) do
        Advert.available.from('adverts, secondhands')
          .where('adverts.id != ? AND adverts.advertable_type = ? ' + '
            AND adverts.advertable_id = secondhands.id AND secondhands.category = ?',
               @advert.id, 'Secondhand', Secondhand.categories[@advertable.category])
          .order("RANDOM()").take(3)
       end
    elsif type == 'evarkadasi'
      @similar = Rails.cache.fetch("similar/#{id}", :expires_in => 5.minutes) do
        Advert.available.where(:advertable_type => 'Homemate').where.not(:id => @advert.id)
          .order("RANDOM()").take(3)
      end
    elsif type == 'ozelders'
      @similar = Rails.cache.fetch("similar/#{id}", :expires_in => 5.minutes) do
        Advert.available.from('adverts, privatelessons')
        .where('adverts.id != ? AND adverts.advertable_type = ? ' + '
          AND adverts.advertable_id = privatelessons.id AND privatelessons.lecture = ?',
             @advert.id, 'Privatelesson', Privatelesson.lectures[@advertable.lecture])
        .order("RANDOM()").take(3)
      end
    end
    
    
    
    if @advert.active == false
      
      render 'ilankapandi'
      
      
    end
    
    
    
    

  end

  def ilanver

    if !current_user
      redirect_to "/girisyap"
    end

  end

  def ilanguncelle

    advert_name = params[:advert_name]
    id = advert_name.split('-')[-1]
    @advert = Advert.available.find_by(:id => id, :verified => true)

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

    elsif params[:advert_type] == 'privatelesson'

      advertableparam = params.require(:advert).require(:privatelesson).permit(
      :kind, :lecture, :state, :city, :location)

    end

    advertParam = params.require(:advert).permit(:name, :price, :explication)
    id = params.require(:advert).permit(:id)[:id]

    advert = Advert.find(id)
    if !current_user || (advert.user!=current_user && current_user.role!='admin')
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

  def imagetotop

    advert = Advert.find(params[:advert])

    image = Image.find(params[:image])

    if !current_user || (advert.user!=current_user && current_user.role!='admin')

      respond_to do |format|
        msg = {:check => false}
        format.json { render :json => msg}

      end

    elsif advert.images.include? image

      advert.image = image

      advert.save

      respond_to do |format|
        msg = {:check => true}
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
    
    captcha = params["g-recaptcha-response"]
    postParams = {
      :secret => "6Ld3uhYTAAAAADMhUY5DpJr2e333FOvp-ZWv45Ki",
      :response => captcha,
      :remoteip => request.remote_ip
    }
    
    x = Net::HTTP.post_form(
      URI.parse('https://www.google.com/recaptcha/api/siteverify'), postParams)

    if JSON.parse(x.body)["success"] && @advert.save
      AdvertMailer.ilanekleme(@advert).deliver_now if Rails.env.production? 
      redirect_to('/?yeniilan=1')
    else
      redirect_to('/ilanver')
    end

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
      elsif subkategori=="incikboncuk"
        @title="İncik Boncuk"
      elsif subkategori=="diger"
        @title="Diğer"
      elsif !subkategori
        @title="İkinci El İlanlar"
      else
        raise ActionController::RoutingError.new('Not Found') 
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
      elsif !subkategori
        @title="Özel Ders İlanları"
      else
        raise ActionController::RoutingError.new('Not Found')
      end

    else
      redirect_to "/kategoriler/ikincielilan"
      return
    end

    @adverts = Rails.cache.fetch("#{request.path}/#{params[:page]}", :expires_in => 5.minutes) do
      @adverts.order("created_at DESC").paginate(:page => params[:page], :per_page => 18).take(18)
    end

    @gununilanlari = Rails.cache.fetch("index_gununilanlari", :expires_in => 5.minutes) do
      gununilanlari.take(8)
    end

    @mostpopular = Rails.cache.fetch("index_mostpopular", :expires_in => 5.minutes) do
      mostpopular.take(8)
    end

  end

  def firsatlar

    if params[:acililanlar]!=nil
      @title="Acil İlanlar"
      @active = 0
      @adverts = acililanlar
    elsif params[:gununfirsatlari]!=nil
      @title="Günün Fırsatları"
      @active = 1
      @adverts = gununilanlari
    elsif params[:ensonilanlar]!=nil
      @title="En Son İlanlar"
      @active = 2
      @adverts = ensonilanlar
    elsif params[:enpopulerilanlar]!=nil
      @title="En Popüler İlanlar"
      @active = 3
      @adverts = mostpopular
    elsif params[:enguvenilirsaticilar]!=nil
      @title="En Güvenilir Satıcılar"
      @active = 4
      @users = enguvenilir
      @adverts = []
    elsif params[:kendiuniversitemdekiler]!=nil
      @title="Kendi Üniversitemdeki İlanlar"
      @active = 5
      if current_user
        @adverts = kendiuniversitem
      else
        @adverts = []
      end

    else
      @title="Acil İlanlar"
      @active = 0
      @adverts = acililanlar
    end

    @adverts = @adverts.paginate(:page => params[:page], :per_page => 18)

    @bizimsectiklerimiz = Rails.cache.fetch("index_bizimsectiklerimiz", :expires_in => 5.minutes) do
      bizimsectiklerimiz.take(10)
    end

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
  
  def close
    advert = Advert.find_by(:id => params[:advert])
    if !current_user || (advert.user!=current_user && current_user.role!='admin')
      respond_to do |format|
        msg = { :check => false }
        format.json  { render :json => msg }
      end
    else
      advert.update_attributes(:active => false)
      respond_to do |format|
        msg = { :check => true }
        format.json  { render :json => msg }
      end
    end
  end

end
