class AnnounceMailer < ApplicationMailer
  
  def iletisim(name, email, subject, message)  
    mail(:to => "info@campusilan.com", :subject => subject, 
      :content_type => "text/html") do |format|
        format.text { render :text => message + " #{email}" }
    end
  end
  
  def ulasti(email, message)
    mail(:to => email, :subject => "Mesaj Gönderme Başarılı", 
      :content_type => "text/html") do |format|
        format.text { render :text => message }
    end
  end
  
end
