class CreatePrivatelessons < ActiveRecord::Migration
  def change
    create_table :privatelessons do |t|

      t.integer :lecture
      t.string :state
      t.string :city
      t.integer :kind
      t.integer :location
      
    
      
      
    end
  end
end
