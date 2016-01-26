class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
  
      t.references :user, :index => true
      t.references :advertable, :polymorphic => true
      
      t.string :name
      t.integer :price
      t.text :explication
      t.boolean :active
      t.boolean :verified
      t.boolean :urgent
      t.boolean :opportunity
      t.boolean :ours
      
      t.references :image
      
      t.timestamps null: false
      
    end
  end
end
