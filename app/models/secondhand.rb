class Secondhand < ActiveRecord::Base

  validates :category, :presence => true

  validates :usage, :warranty, :inclusion => { :in => [true, false] }

  validates :brand, :format => {
    :with => /\A[ -~\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]{0,20}\z/
  }

  has_one :advert, :as => :advertable 

  enum :category => [ :beyazesya, :evdekorasyonu, :muzikaletleri, :elektronik, :kirtasiye,
     :mutfakesyalari, :vasita, :giyim, :kitapdersnotu, :takimucevher, :diger ]

  enum :color => [ :siyah, :beyaz, :kirmizi, :mavi, :sari, :yesil, :diger2, :turuncu, :pembe, :mor, :altin ]
  
  
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
      
       elsif self.color=='turuncu'
      return 'Turuncu'
      
      elsif self.color=='pembe'
      return 'Pembe'
      
      elsif self.color=='mor'
      return 'Mor'
      
       elsif self.color=='altin'
      return 'Altın'
      
      elsif self.color=='diger'
      return 'Diğer'
      
      
      
      

    end

  end

end
