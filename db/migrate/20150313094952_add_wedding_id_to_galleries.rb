class AddWeddingIdToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :wedding_id, :integer
  end
end
