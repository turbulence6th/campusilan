class CreateViewedAdvertCounts < ActiveRecord::Migration
  def change
    create_table :viewed_advert_counts do |t|
        
        t.references :advert
        t.string :ip
        
    end
  end
end
