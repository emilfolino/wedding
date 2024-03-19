class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name
      t.string :url
      t.references :wedding, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
