class CreateQandas < ActiveRecord::Migration
  def change
    create_table :qandas do |t|
      t.text :body
      t.integer :parent_id
      t.references :wedding, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :qandas, :weddings
    add_foreign_key :qandas, :users
  end
end
