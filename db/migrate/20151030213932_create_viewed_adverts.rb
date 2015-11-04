class CreateViewedAdverts < ActiveRecord::Migration
  def change
    create_table :viewed_adverts, id: false do |t|

      t.references :user, index: true
      t.references :advert, index: true
      
    end
  end
end
