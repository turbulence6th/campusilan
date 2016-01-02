class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|

      t.references :from, :references => :user, :index => true
      t.references :to, :references => :user, :index => true
      t.string :topic
      t.text :text
      t.boolean :fromdeleted
      t.boolean :todeleted
      
      t.timestamps null: false
      
      
    end
  end
end
