class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|

      t.references :from, :references => :user, :index => true, :null => false
      t.references :to, :references => :user, :index => true, :null => false
      t.string :topic, :null => false
      t.text :text, :null => false
      t.timestamps null: false
      
    end
  end
end
