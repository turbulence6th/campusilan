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
      msg = { :check => !User.create(:email => email).errors[:email].any?, :unicheck => uni!=nil }
      format.json  { render :json => msg }
    end
  end

  def registerPost

    @user = User.new(params.require(:user).permit(:name, :surname, :username, :password, :password_confirmation, :email, :email_confirmation,
   :phone1, :phone2, :bulletin, :gender))

    @user.phone = @user.phone1 + '-' + @user.phone2
    @user.role = 'member'
    @user.verified = false
    @user.deleted = false
    
    @user.email = @user.email.downcase if @user.email
    @user.email_confirmation = @user.email_confirmation.downcase if @user.email_confirmation
    
    @user.university = University.find_by_email(@user.email.partition('@').last) if @user.email
    @user.confirm_token = SecureRandom.urlsafe_base64.to_s
    
    if @user.save
      #send mail
    end

    redirect_to "/"

  end
  
  def verify
    
    @user = User.find_by(:username => params[:user])
    if @user && @user.confirm_token==params[:token]
      @user.update_attributes(:verified => true, :confirm_token => nil)
    end
    redirect_to '/'
    
  end

  def loginPost
    user = User.valid.find_by_username(params[:username]).try(:authenticate, params[:password])
    if (user!=nil && user!=false)
      session[:user_id] = user.id
      if request.referer
        redirect_to URI(request.referer).path
      else
        redirect_to "/"
      end
    else
      redirect_to "/girisyap?hataligiris=1"
    end
  end
  
  def updateUser
    attr = params.require(:user).permit(:name, :surname, :phone1, :phone2, :bulletin, :gender, :address, :birthday)
    attr.merge! :phone => attr[:phone1] + '-' + attr[:phone2]
    current_user.update_attributes(attr)
    redirect_to '/uye/' + current_user.username + '?hesapayarlari=1'
  end

  def member
    
    @mostpopular = mostpopular.limit(6)
    
    @gununilanlari = gununilanlari.limit(9)
    
    @lastadverts = current_user.adverts.order('created_at DESC').limit(6)
    
   
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
    
    @other_user=User.valid.find_by_username(params[:username])
    
    if @other_user == nil 
      raise ActionController::RoutingError.new('Not Found') 
    elsif  current_user != @other_user
      render 'member2'
    else
      
      current_user.phone1 =  current_user.phone.split('-')[0]
      current_user.phone2 =  current_user.phone.split('-')[1]
      
      @favouriteadverts = Advert.available.select('adverts.*').from('adverts, users, favourite_adverts')
        .where('adverts.id=favourite_adverts.advert_id AND users.id=favourite_adverts.user_id AND users.id=?', current_user.id)
        .order('favourite_adverts.created_at DESC').limit(6)
      
      
       @viewedadverts = Advert.available.select('adverts.*').from('adverts, users, viewed_adverts')
        .where('adverts.id=viewed_adverts.advert_id AND users.id=viewed_adverts.user_id')
        .order('viewed_adverts.created_at').limit(6)
      
    end

  end

  def login
    if current_user!=nil
      redirect_to "/"
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
      
      reset_session
      
      redirect_to "/"
      
     else
       
       raise ActionController::RoutingError.new('Not Found') 
    end
    
  
    
    
  end
  
  
  
  
 

end