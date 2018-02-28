class CreateHomemates < ActiveRecord::Migration
  def change
    create_table :homemates do |t|

      t.string :state
      t.string :city
      t.integer :demand
      
      t.integer :sleep
      t.integer :friend
      t.integer :smoke
      t.integer :department
      t.integer :music
      
     
    end
  end
end
