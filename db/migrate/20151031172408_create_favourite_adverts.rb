class CreateFavouriteAdverts < ActiveRecord::Migration
  def change
    create_table :favourite_adverts, id: false do |t|

      t.references :user, index: true
      t.references :advert, index: true
      
    end
    
    execute "ALTER TABLE favourite_adverts ADD PRIMARY KEY (user_id, advert_id);"
    
  end
end
