class Verification < ApplicationMailer
  def verify(to)
    @greeting = "Hi"

    mail :to => to, :subject => 'Kayıt'
    #Verification.verify('turbulence6th@gmail.com').deliver
  end
end
