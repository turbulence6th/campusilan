class CreateFavouriteAdverts < ActiveRecord::Migration
  def change
    
    create_table :favourite_adverts do |t|

      t.references :user, index: true
      t.references :advert, index: true
      
      t.timestamps :null => false
      
    end
    
  end
end
