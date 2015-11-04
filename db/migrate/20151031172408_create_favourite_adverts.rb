class CreateFavouriteAdverts < ActiveRecord::Migration
  def change
    create_table :favourite_adverts, id: false do |t|

      t.references :user, index: true
      t.references :advert, index: true
      
    end
  end
end
