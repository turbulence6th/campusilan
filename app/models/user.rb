class User < ActiveRecord::Base
  
  scope :valid, -> { where(:deleted => false, :verified => true) }
  
  validates :name, :surname, :username, :role, :gender, :university, :presence => true
  
  validates :password_confirmation, :presence => true, :if => :password_digest_changed?
  
  validates :email_confirmation, :presence => true, :if => :email_changed?
  
  validates :username, :uniqueness => true
  
  validates :email, :uniqueness => { :case_sensitive => false }
  
  validates :verified, :bulletin, :deleted, :inclusion => { :in => [true, false] }
  
  validates :password, :email, :confirmation => true
  
  validates :email, :length => {
    :minimum => 2,
    :maximum => 40
  }
  
  validates :address, :length => {
    :maximum => 500
  }
  
  validates :name, :format => {
    :with => /\A[ a-zA-Z\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]{1,20}\z/
  }
  
  validates :surname, :format => {
    :with => /\A([a-zA-Z\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]*([ '-][a-zA-Z\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc])*){1,20}\z/
  }
  
  validates :username, :format => {
    :with => /\A[a-z0-9._-]{3,15}\z/
  }
  
  validates :email, :format => {
    :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  }
  
  validates :password, :format => {
    :with => /((?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20})/
  }, :if => :password_digest_changed?
  
  validates :phone, :format => {
    :with => /\d{3}-\d{7}/,
    :allow_blank => true
  }
    
  has_secure_password

  attr_accessor :phone1, :phone2
  
  enum :gender => [ :male, :female, :other ]
  enum :role => [ :admin, :member ]
  
  has_many :adverts, :dependent => :destroy
  
  has_many :viewed_adverts, :dependent => :destroy
  
  has_many :favourite_adverts, :dependent => :destroy
 
  has_many :froms, :class_name => 'Message', :foreign_key => 'from_id', :dependent => :destroy
  has_many :tos, :class_name => 'Message', :foreign_key => 'to_id', :dependent => :destroy
  
  belongs_to :university
  
  has_one :image, :as => :imageable, :dependent => :destroy
  
  has_many :votes, :dependent => :destroy
  
  has_many :images
  
  def href
    "uye/" + self.username
  end
  
  
end
