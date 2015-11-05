class CreateViewedAdverts < ActiveRecord::Migration
  def change
    create_table :viewed_adverts, id: false do |t|

      t.references :user, :index => true, :null => false
      t.references :advert, :index => true, :null => false
      
    end
    
    execute "ALTER TABLE viewed_adverts ADD PRIMARY KEY (user_id, advert_id);"
    
  end
end
