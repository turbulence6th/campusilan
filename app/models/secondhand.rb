class Secondhand < ActiveRecord::Base
  
  has_one :advert, :as => :advertable
  
  enum :category => [ :beyazesya, :evdekorasyon, :muzikaletleri, :elektronik, :kirtasiye, 
     :mutfakesyalari, :diger ]
  
  enum :color => [ :siyah, :beyaz, :kirmizi, :mavi, :sari, :yesil ]
  
end
