class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    require 'rspotify'

    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

    playlist = spotify_user.create_playlist!('wedding-playlist')
    tracks = RSpotify::Track.search('Det draaar')
    playlist.add_tracks!(tracks)

    current_user.weddings.first.update_attributes(:playlist_id => playlist.id, :spotify_name => spotify_user.id, :spotify_hash => spotify_user.to_hash)

    redirect_to '/playlist/' + current_user.weddings.first.id.to_s
  end
end
