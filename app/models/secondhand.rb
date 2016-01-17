class Secondhand < ActiveRecord::Base
  
  validates :category, :color, :brand, :presence => true
  
  validates :usage, :warranty, :inclusion => { :in => [true, false] }
  
  validates :brand, :format => {
    :with => /\A[ -~\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]{1,20}\z/
  }
  
  has_one :advert, :as => :advertable
  
  enum :category => [ :beyazesya, :evdekorasyon, :muzikaletleri, :elektronik, :kirtasiye, 
     :mutfakesyalari, :vasita,:giyim,:dersnotu, :diger ]
  
  enum :color => [ :siyah, :beyaz, :kirmizi, :mavi, :sari, :yesil ]
  
  def renkler
    
     if self.color=='siyah'
       return 'Siyah'
       
      elsif self.color=='beyaz'
       return 'Beyaz'
       
      elsif self.color=='kirmizi'
       return 'Kırmızı'
       
      elsif self.color=='mavi'
       return 'Mavi'
       
      elsif self.color=='sari'
       return 'Sarı'   
       
      elsif self.color=='yesil'
       return 'Yeşil'   
       
     end
    
    
    
  end
  
  
end
