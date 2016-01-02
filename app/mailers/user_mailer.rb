class UserMailer < ApplicationMailer
  
  def verify(user)
    
    @user = user
    mail :to => @user.email, :subject => 'Doğrulama Maili'
    
  end
  
  def forgot_password(user)
    
  end
  
end
