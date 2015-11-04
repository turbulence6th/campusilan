class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :username, :null => false
      t.string :password_digest, :null => false
      t.string :name, :null => false
      t.string :surname, :null => false
      t.string :email, :null => false
      t.string :phone, :null => false
      t.integer :role, :null => false
      t.integer :gender, :null => false
      t.boolean :verified, :null => false
      t.boolean :bulletin, :null => false
      
      t.timestamps :null => false
    end
    
    add_index :users, [:username, :email], :unique => true
    
  end
end
