class AddSpotifyNameToWeddings < ActiveRecord::Migration
  def change
    remove_column :users, :spotify_name
    remove_column :users, :spotify_hash

    add_column :weddings, :spotify_name, :string
    add_column :weddings, :spotify_hash, :text
  end
end
