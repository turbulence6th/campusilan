class Verification < ApplicationMailer

  default :from => "e194239@metu.edu.tr"
  
  def verify
    @greeting = "Hi"

    mail to: "turbulence6th@gmail.com"
  end
end
