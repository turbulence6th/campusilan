class CreateSecondhands < ActiveRecord::Migration
  def change
    create_table :secondhands do |t|

      t.integer :category
      t.integer :color
      t.string :brand
      t.boolean :usage
      t.boolean :warranty 
      
    end
  end
end
