class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
  
      t.references :user, :index => true
      t.references :advertable, :polymorphic => true, :index => true
      
      t.string :name
      t.integer :price
      t.text :explication
      t.boolean :active
      t.boolean :urgent
      t.boolean :opportunity
      
      t.timestamps null: false
      
    end
  end
end
