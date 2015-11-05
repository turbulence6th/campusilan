class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
  
      t.references :user, :index => true, :null => false    
      t.timestamps null: false
      
    end
  end
end
