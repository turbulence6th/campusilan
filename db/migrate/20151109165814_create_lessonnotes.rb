class CreateLessonnotes < ActiveRecord::Migration
  def change
    create_table :lessonnotes do |t|

      t.integer :category
      
    end
  end
end
