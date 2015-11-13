class UserController < ApplicationController

  using TurkishSupport

  layout false
  
  helper_method :current_user
  
  def register
    if current_user!=nil
      redirect_to "/"
    end
    
    @user=User.new
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
    respond_to do |format|
      msg = { :check => !User.create(:email => email).errors[:email].any? }
      format.json  { render :json => msg }
    end
  end

  def registerPost

   @user = User.new(params.require(:user).permit(:name, :surname, :username, :password, :password_confirmation, :email, :email_confirmation,
   :phone1, :phone2, :bulletin, :gender))
   
   @user.phone = @user.phone1 + '-' + @user.phone2
   @user.role = 'member'
   @user.verified = false
   @user.save

    redirect_to "/"

  end

  def loginPost
    user = User.find_by_username(params[:username]).try(:authenticate, params[:password])
    if (user!=nil && user!=false)
      session[:user_id] = user.id
      redirect_to "/"
    else
      redirect_to "/girisyap?hataligiris=1"
    end
  end

  def member
    
    if current_user==nil
      redirect_to "/"
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
  

end