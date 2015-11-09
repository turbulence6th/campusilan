class Secondhand < ActiveRecord::Base
  
  has_one :advert, :as => :advertable
  
end
