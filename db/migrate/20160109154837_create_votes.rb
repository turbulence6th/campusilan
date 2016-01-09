class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      
      t.references :user, :index => true
      t.references :advert, :index => true
      
      t.string :point

      t.timestamps null: false
    end
  end
end
