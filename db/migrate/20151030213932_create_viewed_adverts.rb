class CreateViewedAdverts < ActiveRecord::Migration
  def change
    
    create_table :viewed_adverts do |t|

      t.references :user, :index => true
      t.references :advert, :index => true
      
      t.timestamps :null => false
      
    end
    
  end
end
