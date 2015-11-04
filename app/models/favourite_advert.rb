class FavouriteAdvert < ActiveRecord::Base
  belongs_to :user
  belongs_to :advert
end
