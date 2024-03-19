class AddPlaylistToWeddings < ActiveRecord::Migration
  def change
    add_column :weddings, :playlist_id, :string
  end
end
