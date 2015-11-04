class ViewedAdvert < ActiveRecord::Base
  belongs_to :user
  belongs_to :advert
end
