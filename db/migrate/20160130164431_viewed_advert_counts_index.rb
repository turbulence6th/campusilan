class ViewedAdvertCountsIndex < ActiveRecord::Migration
  def change
    add_index :viewed_advert_counts, :advert_id
  end
end
