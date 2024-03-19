class CreateWeddingDescriptions < ActiveRecord::Migration
  def change
    create_table :wedding_descriptions do |t|
      t.text :body
      t.references :wedding, index: true
      t.references :language, index: true

      t.timestamps null: false
    end
    add_foreign_key :wedding_descriptions, :weddings
    add_foreign_key :wedding_descriptions, :languages
  end
end
