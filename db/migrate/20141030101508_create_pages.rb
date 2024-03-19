class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :page_title
      t.text :page_body
      t.references :wedding, index: true
      t.references :language, index: true

      t.timestamps
    end
  end
end
