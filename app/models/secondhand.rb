class Secondhand < ActiveRecord::Base
  
  validates :category, :color, :brand, :presence => true
  
  validates :usage, :warranty, :inclusion => { :in => [true, false] }
  
  validates :brand, :format => {
    :with => /\A[ \+\-_\*\."'a-zA-Z\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]{1,20}\z/
  }
  
  has_one :advert, :as => :advertable
  
  enum :category => [ :beyazesya, :evdekorasyon, :muzikaletleri, :elektronik, :kirtasiye, 
     :mutfakesyalari, :diger ]
  
  enum :color => [ :siyah, :beyaz, :kirmizi, :mavi, :sari, :yesil ]
  
end
