class UserMailer < ApplicationMailer
  
  def verify(user)
    
    @user = user
    mail :to => @user.email, :subject => 'Campus İlan Kayıt Onay E-postası'
    
  end
  
  def forgot_password(user)
    
  end
  
end
