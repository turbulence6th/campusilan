class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :username, :index => true
      t.string :password_digest
      t.string :name
      t.string :surname
      t.string :email, :index => true
      t.string :phone
      t.integer :role
      t.integer :gender
      t.boolean :verified
      t.boolean :bulletin
      
      t.date :birthday
      t.text :address
      t.references :university
      
      t.timestamps :null => false
    end
    
  end
end
