class User < ActiveRecord::Base
  
  validates :name, :surname, :username, :password_confirmation, :email_confirmation, :phone, :role, :gender, :presence => true, :on => :create
  
  validates :username, :email, :uniqueness => true
  
  validates :verified, :bulletin, :inclusion => { :in => [true, false] }
  
  validates :password,:email, :confirmation => true, :on => :create
  
  validates :email, :length => {
    :minimum => 2,
    :maximum => 40
  }
  
  validates :address, :length => {
    :maximum => 500
  }
  
  validates :name, :format => {
    :with => /\A[a-zA-Z\u00c7\u00e7\u011e\u011f\u0130\u0131\u00d6\u00f6\u015e\u015f\u00dc\u00fc]{1,20}\z/
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
  }
  
  validates :phone, :format => {
    :with => /\d{3}-\d{7}/
  }
  
  has_secure_password
  
  enum :gender => [ :male, :female, :other ]
  enum :role => [ :admin, :member ]
  
  has_many :adverts
  
  has_many :viewed_adverts
  has_many :adverts, through: :viewed_adverts
  
  has_many :favourite_adverts
  has_many :adverts, through: :favourite_adverts
  
  has_many :froms, :class_name => 'Message', :foreign_key => 'id'
  has_many :tos, :class_name => 'Message', :foreign_key => 'id'
  
  belongs_to :university
  
end
