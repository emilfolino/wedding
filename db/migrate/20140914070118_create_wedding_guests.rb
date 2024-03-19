class CreateWeddingGuests < ActiveRecord::Migration
  def change
    create_table :wedding_guests do |t|
      t.references :user, index: true
      t.references :wedding, index: true
      t.boolean :accepted, default: false
      t.string :url, default: ""
      t.string :short_token, default: ""

      t.timestamps
    end
  end
end
