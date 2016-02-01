class UserMailer < ApplicationMailer
  
  def verify(user)
    @user = user
    mail :to => @user.email, :subject => 'Campus İlan Kayıt Onay E-postası' 
  end
  
  def forgot_password(user)
    @user = user
    mail :to => @user.email, :subject => 'Campus İlan Şifremi Unuttum'
  end
  
  def sifredegisti(user)
    @user = user
    mail :to => @user.email, :subject => 'Campus İlan Şifrenizi Değiştirdiniz'
  end
  
end
