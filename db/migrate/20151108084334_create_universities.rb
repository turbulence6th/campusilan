class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      
      t.string :name
      t.string :email, :index => true
      
    end
  end
end
