class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if current_user.token.nil?
      require 'flickraw'

      FlickRaw.api_key= ""
      FlickRaw.shared_secret= ""

      token = flickr.get_request_token
      session[:flickr_token] = token
      @auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'delete')
    else
      redirect_to new_gallery_path
    end
  end

  def show
    begin
      require 'flickraw'
      FlickRaw.api_key= ""
      FlickRaw.shared_secret= ""

      @wedding = Wedding.find(@gallery.wedding_id)

      flickr.access_token = @wedding.user.token
      flickr.access_secret = @wedding.user.token_secret
      # # From here you are logged:
      login = flickr.test.login

      @photo_urls = Array.new

      photos = flickr.photosets.getPhotos(:photoset_id => @gallery.flickr_id)
      photos.photo.each do |photo|
        info = flickr.photos.getInfo(:photo_id => photo.id)
        @photo_urls.push(FlickRaw.url(info))
      end
      respond_with(@gallery)
    rescue FlickRaw::FailedResponse => e
      puts "Authentication failed : #{e.msg}"
    end
  end

  def new
    if params[:flickr_numbers]
      begin
        require 'flickraw'

        FlickRaw.api_key= ""
        FlickRaw.shared_secret= ""

        verify = params[:flickr_numbers]
        token = session[:flickr_token]
        flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], verify)
        login = flickr.test.login

        current_user.update_attributes(:token => flickr.access_token, :token_secret => flickr.access_secret)
      rescue FlickRaw::FailedResponse => e
        puts "Authentication failed : #{e.msg}"
      end
    end

    @gallery = Gallery.new
    respond_with(@gallery)
  end

  def edit
  end

  def create

    begin
      require 'flickraw'
      FlickRaw.api_key= ""
      FlickRaw.shared_secret= ""

      flickr.access_token = current_user.token
      flickr.access_secret = current_user.token_secret
      # # From here you are logged:
      login = flickr.test.login

      photo_ids = Array.new
      params[:files].each do |file|
        photo_ids.push(flickr.upload_photo file.tempfile, :title => file.original_filename, :description => file.original_filename)
      end

      flickr_photoset = flickr.photosets.create(:title => gallery_params["gallery_name"],:description => gallery_params["gallery_description"], :primary_photo_id => photo_ids.shift)

      photo_ids.each do |photo_id|
        flickr.photosets.addPhoto(:photoset_id => flickr_photoset.id, :photo_id => photo_id)
      end

      @gallery = Gallery.new(gallery_params)
      @gallery.flickr_id = flickr_photoset.id
      @gallery.wedding_id = current_user.weddings.first.id
      @gallery.save
      respond_with(@gallery)

    rescue FlickRaw::FailedResponse => e
      puts "Authentication failed : #{e.msg}"
    end
  end

  def update
    @gallery.update(gallery_params)
    respond_with(@gallery)
  end

  def destroy
    @gallery.destroy
    respond_with(@gallery)
  end

  def wedding_galleries
    @wedding = Wedding.find(params[:wedding_id])
    @pages = @wedding.pages.where(language_id: current_user.language_id).order("sort_order ASC")
    @galleries = Gallery.where(:wedding_id => params[:wedding_id])
  end

  private
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    def gallery_params
      params.require(:gallery).permit(:gallery_name, :gallery_description, :flickr_id, :wedding_id)
    end
end
