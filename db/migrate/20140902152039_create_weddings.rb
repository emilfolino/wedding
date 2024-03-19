class CreateWeddings < ActiveRecord::Migration
  def change
    create_table :weddings do |t|
      t.string :title
      t.datetime :wedding_date
      t.references :user, index: true

      t.timestamps
    end
  end
end
