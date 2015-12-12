class CreateHomemates < ActiveRecord::Migration
  def change
    create_table :homemates do |t|

      t.string :state
      t.string :city
      t.string :zipcode
      t.integer :demand
     
    end
  end
end
