class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :gallery_name
      t.text :gallery_description
      t.string :flickr_id

      t.timestamps null: false
    end
  end
end
