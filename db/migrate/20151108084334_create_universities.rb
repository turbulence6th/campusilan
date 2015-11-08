class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      
      t.string :name, :index => true
      
    end
  end
end
