class Advert < ActiveRecord::Base
  
  scope :available, -> { where(:verified => true, :active => true) }
  
  validates :name, :price, :explication, :user, :advertable, :presence => true
  
  validates :active, :urgent, :opportunity, :ours, :inclusion => { :in => [true, false] }
  
  validates :name, :format => {
    :with => /\A[ -~\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]{1,60}\z/
  }
  
  validates :price, :numericality => { :only_integer => true }
  
  validates :price, :length => {
    :maximum => 7
  }
  
  validates :explication, :length => {
    :maximum => 1000
  }
  
  validates :images, :length => {
    :maximum => 5
  }
  
  belongs_to :user
  
  has_many :viewed_adverts, :dependent => :destroy
  
  
  has_many :favourite_adverts, :dependent => :destroy
  
  
  belongs_to :advertable, :polymorphic => true, :dependent => :destroy
  
  has_many :images, :as => :imageable, :dependent => :destroy
  
  has_many :viewed_advert_counts, :dependent => :destroy
  
  has_many :votes, :dependent => :destroy
  
  def href
    
    if self.advertable_type=='Secondhand'
      path = '/ikinciel/'
    elsif self.advertable_type=='Homemate'
      path = '/evarkadasi/'
    elsif self.advertable_type=='Privatelesson'
      path = '/ozelders/'
    end
    
    path + self.name.parameterize + '-' + self.id.to_s
    
  end
  
  def href_guncelle
    

    '/ilanguncelle/' + self.name.parameterize + '-' + self.id.to_s
    
  end
  
end
