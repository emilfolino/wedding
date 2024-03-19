class AddSpotifyNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :spotify_name, :string
    add_column :users, :spotify_hash, :text
  end
end
