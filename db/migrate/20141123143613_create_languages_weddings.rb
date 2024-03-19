class CreateLanguagesWeddings < ActiveRecord::Migration
  def change
    create_table :languages_weddings do |t|
      t.references :language, index: true
      t.references :wedding, index: true
    end
  end
end
