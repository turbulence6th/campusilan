class AdvertMailer < ApplicationMailer
  
  def ilanekleme(advert)
    
    @advert = advert
    @user = advert.user
    mail :to => @user.email, :subject => 'İlanınız Başarıyla Alındı'
    
  end
  
  def ilanonay(advert)
    
    @advert = advert
    @user = advert.user
    mail :to => @user.email, :subject => 'İlanınız Onaylandı'
    
  end
  
  def removeAdvert(advert)
    
  end
  
end
