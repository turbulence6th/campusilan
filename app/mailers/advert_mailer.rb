class AdvertMailer < ApplicationMailer
  
  def newAdvert(advert)
    
    @advert = advert
    @user = advert.user
    mail :to => @user.email, :subject => 'İlanınız Başarıyla Alındı'
    
  end
  
  def verifiedAdvert(advert)
    
  end
  
  def removeAdvert(advert)
    
  end
  
end
