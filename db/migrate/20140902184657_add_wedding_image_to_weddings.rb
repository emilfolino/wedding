class AddWeddingImageToWeddings < ActiveRecord::Migration
  def change
    add_column :weddings, :image, :string
  end
end
