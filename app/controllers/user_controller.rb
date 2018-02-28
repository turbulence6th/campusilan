class UserController < ApplicationController

  using TurkishSupport

  layout false

  helper_method :current_user
  def register
    if current_user!=nil
      redirect_to "/"
    end
  end

  def checkusername
    username = params[:username]
    respond_to do |format|
      msg = { :check => !User.create(:username => username).errors[:username].any? }
      format.json  { render :json => msg }
    end
  end

  def checkemail
    email = params[:email]
    uni = University.find_by_email(email.downcase.partition('@').last) if email
    respond_to do |format|
      msg = { :check => !User.create(:email => email).errors[:email].any? }
      format.json  { render :json => msg }
    end
  end

  def registerPost

    @user = User.new(params.require(:user).permit(:name, :surname, :username, :password, :password_confirmation, :email, :email_confirmation,
     :bulletin, :gender))

    @user.role = 'member'
    @user.verified = false
    @user.deleted = false

    @user.email = @user.email.downcase if @user.email
    @user.email_confirmation = @user.email_confirmation.downcase if @user.email_confirmation

    @user.university = University.find_by_email(@user.email.partition('@').last) if @user.email
    @user.confirm_token = SecureRandom.urlsafe_base64.to_s

    captcha = params["g-recaptcha-response"]
    postParams = {
      :secret => "6Ldkq0kUAAAAAOlD1Du-GIF7LALxD5xc7KBuFA5Y",
      :response => captcha,
      :remoteip => request.remote_ip
    }

    x = Net::HTTP.post_form(
    URI.parse('https://www.google.com/recaptcha/api/siteverify'), postParams)

    if JSON.parse(x.body)["success"] && @user.save
      Thread.new do
        UserMailer.verify(@user).deliver_now if Rails.env.production?
      end
      redirect_to('/?yenihesap=1')
    else
      redirect_to('/kayitol')
    end

  end

  def verify

    @user = User.find_by(:username => params[:user])
    if @user && @user.confirm_token==params[:token]
      @user.update_attributes(:verified => true, :confirm_token => nil)
      reset_session
      session[:user_id] = @user.id
    end
    redirect_to '/'

  end

  def loginPost
    user = User.find_by_username(params[:username]).try(:authenticate, params[:password])
    if (user && user.verified && !user.deleted)

      reset_session

      if params[:remember] != 1
        session[:expires_at] = 10.minutes.from_now
      end

      session[:user_id] = user.id
      if request.referer
        redirect_to URI(request.referer).path
      else
        redirect_to "/"
      end
    elsif (user && user.deleted)
      redirect_to "/girisyap?silinmis=1"
    elsif (user && !user.verified)
      redirect_to "/girisyap?onay=1"
    else
      redirect_to "/girisyap?hataligiris=1"
    end
  end

  def ilanonay

    if current_user && current_user.role == 'admin'
      @adverts = Advert.where(:verified =>false)
      if params[:id]!= nil
        id = params[:id]
        a = Advert.find(id)
        a.verified = true
        a.save
        Thread.new do
          AdvertMailer.ilanonay(a).deliver_now if Rails.env.production?
        end
      end
    else
      raise ActionController::RoutingError.new('Not Found')
    end

  end

  def ilansil
    if current_user && current_user.role == 'admin'
      if params[:id]!= nil
        id = params[:id]
        a = Advert.find_by(:id => id)
        a.destroy
        redirect_to '/ilanonay'
      end
    else
      raise ActionController::RoutingError.new('Not Found')
    end

  end

  def updateUser
    attr = params.require(:user).permit(:name, :surname, :phone1, :phone2, :bulletin, :gender,
    :address, :birthday)
    phone = attr[:phone1] + '-' + attr[:phone2]
    if phone != "-"
      attr.merge! :phone => phone
    else
      attr.merge! :phone => nil
    end

    uni = University.find_by(:id => params[:university_id])
    current_user.university = uni
    current_user.update_attributes(attr)
    redirect_to '/uye/' + current_user.username + "?hesapayarlari=1"
  end

  def member

    @mostpopular = Rails.cache.fetch("user_mostpopular", :expires_in => 5.minutes) do
      mostpopular.take(6)
    end

    @gununilanlari = Rails.cache.fetch("user_gununilanlari", :expires_in => 5.minutes) do
      gununilanlari.take(12)
    end

    if params[:profilim]!=nil
      @sekme=".profilim"
    elsif params[:ilanver]!=nil
      @sekme=".ilanver"
    elsif params[:satislarim]!=nil
      @sekme=".satislarim"
    elsif params[:alislarim]!=nil
      @sekme=".alislarim"
    elsif params[:favorilerim]!=nil
      @sekme=".favoriler"
    elsif params[:mesajlarim]!=nil
      @sekme=".mesajlarim"
    elsif params[:tekliflerim]!=nil
      @sekme=".tekliflerim"
    elsif params[:inceledigimilanlar]!=nil
      @sekme=".inceledigimilanlar"
    elsif params[:hesapayarlari]!=nil
      @sekme=".hesapayarlari"
    else
      @sekme=".profilim"
    end

    @other_user=User.valid.find_by(:username => params[:username])

    if @other_user == nil
      raise ActionController::RoutingError.new('Not Found')

    elsif  current_user==nil || current_user.id != @other_user.id

      @lastadverts = @other_user.adverts.where(:verified => true).order('created_at DESC').limit(8)
      render 'member2'

    else

      if current_user.phone
        current_user.phone1 =  current_user.phone.split('-')[0]
        current_user.phone2 =  current_user.phone.split('-')[1]
      end

      @lastadverts = current_user.adverts.where(:verified => true).order('created_at DESC').limit(6)

      @favouriteadverts = Advert.available.select('adverts.*').from('adverts, users, favourite_adverts')
        .where('adverts.id=favourite_adverts.advert_id AND users.id=favourite_adverts.user_id AND users.id=?', current_user.id)
        .order('favourite_adverts.created_at DESC').limit(6)

      @viewedadverts = Advert.available.select('adverts.*').from('adverts, viewed_adverts')
        .where('adverts.id=viewed_adverts.advert_id AND viewed_adverts.user_id = ?', current_user.id)
        .order('viewed_adverts.created_at DESC').limit(6)

      @universities = Rails.cache.fetch("universities", :expires_in => 5.minutes) do
         University.order(:name).collect { |a| [a.name, a.id] }
      end

    end

  end

  def profilephoto

    if params[:profilephoto]

      if current_user.image!= nil
        current_user.image.destroy
      end

      @image = Image.new(:imagefile => params[:profilephoto])
      @image.user = current_user
      current_user.image = @image

      redirect_to URI(request.referer).path

    elsif params[:deletephoto]

      if current_user.image!= nil
        current_user.image.destroy
        redirect_to URI(request.referer).path

      else

        redirect_to URI(request.referer).path

      end

    end

  end

  def login
    if current_user!=nil
      redirect_to "/"
    end
  end

  def aktivasyonpost

    captcha = params["g-recaptcha-response"]
    postParams = {
      :secret => "6Ldkq0kUAAAAAOlD1Du-GIF7LALxD5xc7KBuFA5Y",
      :response => captcha,
      :remoteip => request.remote_ip
    }

    x = Net::HTTP.post_form(
    URI.parse('https://www.google.com/recaptcha/api/siteverify'), postParams)

    if !JSON.parse(x.body)["success"]
      redirect_to('/aktivasyon?captcha=1')
    return
    end
    user = User.find_by(:email => params[:eposta].downcase)

    if user && !user.verified
      user.confirm_token = SecureRandom.urlsafe_base64.to_s
      UserMailer.verify(@user).deliver_now if Rails.env.production?
      user.save
      redirect_to('/?mailgeldi=1')
    elsif
    redirect_to('/aktivasyon?gecersiz=1')
    end
  end

  def sifremiunuttumPost
    captcha = params["g-recaptcha-response"]
    postParams = {
      :secret => "6Ldkq0kUAAAAAOlD1Du-GIF7LALxD5xc7KBuFA5Y",
      :response => captcha,
      :remoteip => request.remote_ip
    }

    x = Net::HTTP.post_form(
    URI.parse('https://www.google.com/recaptcha/api/siteverify'), postParams)

    if !JSON.parse(x.body)["success"]
      redirect_to('/sifremiunuttum?captcha=1')
    return
    end

    user = User.valid.find_by(:email => params[:eposta].downcase)
    if user
      user.confirm_token = SecureRandom.urlsafe_base64.to_s
      UserMailer.forgot_password(user).deliver_now if Rails.env.production?
      user.save
      redirect_to('/?unuttumgeldi=1')
    elsif
    redirect_to('/sifremiunuttum?gecersiz=1')
    end
  end

  def sifredegistir
    user = User.valid.find_by(:username => params[:user])
    if user && user.confirm_token == params[:token]

      else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def sifredegistirPost
    user = User.valid.find_by(:username => params[:user])
    if user && user.confirm_token == params[:token]
      user.password = params[:password]
      user.password_confirmation = params[:password2]
      if user.valid?
        user.confirm_token = nil
        user.save
        UserMailer.sifredegisti(user).deliver_now if Rails.env.production?
        redirect_to('/?sifredegisti=1')
      else
        redirect_to("/sifredegistir?user=#{params[:user]}&token=#{params[:token]}")
      end
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def logout
    reset_session
    redirect_to "/"
  end

  def hesabisil

    if current_user!= nil

      current_user.deleted = true
      current_user.save
      Advert.where(:user_id => current_user.id).update_all(:active => false)

      reset_session

      redirect_to "/"

    else

      raise ActionController::RoutingError.new('Not Found')
    end

  end

end
