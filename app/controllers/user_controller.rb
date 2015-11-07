class UserController < ApplicationController
  
  using TurkishSupport
  
  layout false
  
  def register
    
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
    
    name = params[:name].downcase if params[:name] != nil
    surname = params[:surname].downcase if params[:surname] != nil
    username = params[:username]
    password = params[:password]
    password2 = params[:password2]
    email = params[:email].downcase if params[:email] != nil
    email2 = params[:email2].downcase if params[:email2] != nil
    gender = params[:gender]
    phone = params[:phone] + '-' + params[:phone2]
    bulletin = params[:bulletin]
    
    user = User.new(:name => name, :surname => surname, :username => username, :password => password, 
    :password_confirmation => password2, :email => email, :email_confirmation => email2, 
    :gender => gender, :phone => phone, :bulletin => bulletin, :role => 'member', :verified => false)
    user.save
    
    redirect_to "/"
    
  end
  
  def loginPost
    user = User.find_by_username(params[:username]).try(:authenticate, params[:password])
    if (user!=nil && user!=false)
      session[:user_id] = user.id
    end
    redirect_to "/"
  end
  
end
