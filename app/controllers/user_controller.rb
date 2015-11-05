class UserController < ApplicationController
  
  layout false
  
  def register
    
  end
  
  def checkusername
    
    username = params[:username]
    user = User.find_by_username(username)
    
    if (username =~ /^[a-z0-9._-]{3,15}$/ && user==nil)
      
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
  
  def checkemail
    
    email = params[:email].downcase
    user = User.find_by_email(email)
    
    if (email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i && user==nil)
      
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
  
  def registerPost
    name = params[:name].downcase
    surname = params[:surname].downcase
    username = params[:username]
    password = params[:password]
    password2 = params[:password2]
    email = params[:email].downcase
    email2 = params[:email2].downcase
    gender = params[:gender]
    phone = params[:phone] + '-' + params[:phone2]
    bulletin = params[:bulletin]
    
    check = true
    
    if (!(name =~ /^[a-zA-Z\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]{1,20}$/))
       check = false
    end
    
    if (!(surname =~ /^([a-zA-Z\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]*([ '-][a-zA-Z\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc])*){1,20}$/))
       check = false
    end
    
    if (!(username =~ /^[a-z0-9._-]{3,15}$/))
       check = false
    end
    
    if (!(email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i))
       check = false
    end
    
    if (!(password =~ /((?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20})/))
       check = false
    end
    
    if (!(phone =~ /\d{3}-\d{7}/))
       check = false
    end
    
    if (email != email2 || password != password2)
        check = false
    end
    
    if(check)
      user = User.new(:name => name, :surname => surname, :username => username, :password => password, :password_confirmation => password2,
      :email => email, :gender => gender, :phone => phone, :bulletin => bulletin, :role => 'member', :verified => false)
      user.save
    end
    
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
