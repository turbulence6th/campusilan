class Homemate < ActiveRecord::Base
  
  validates :state, :city, :demand, :sleep, :friend, :smoke, :department, :music, :presence => true
  
  validates :state, :city, :format => {
    :with => /\A[a-zA-Z\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]{1,20}\z/
  }
  
  has_one :advert, :as => :advertable
  
  enum :demand => [ :male, :female, :both ]
  
  enum :sleep => [ :evet, :hayir, :degisken ]
  enum :friend => [ :evet, :hayir, :degisken ]
  enum :smoke => [ :evet, :hayir, :arada ]
  enum :department => [ :muhendislik, :egitim, :tip, :siyasal, :diger ]
  enum :music => [ :evet, :hayir, :arada ]


  def aranan
    
    if self.demand == 'male'
      
      return 'Erkek'
      
    elsif self.demand == 'female'
      
      return 'Kadın' 
      
   
    
    elsif self.demand == 'both'
      
      return 'Hepsi' 
      
    end
    
    
  end


end
