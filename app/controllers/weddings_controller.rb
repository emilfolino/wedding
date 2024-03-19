class WeddingsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_wedding, only: [:show, :edit, :update, :destroy, :accept_wedding_invite, :deny_wedding_invite]

  prawnto :prawn => { :page_size => 'A4', :page_layout => :portrait }

  #after_action :verify_authorized
  # GET /weddings
  # GET /weddings.json
  def index
    @own_wedding = Wedding.where(user: current_user).order('wedding_date').first
    @wedding_guests = WeddingGuest.where(user_id: current_user.id)

    if current_user.admin? && current_user.weddings.first.nil?
      redirect_to new_wedding_path
    elsif @own_wedding
      redirect_to wedding_path(@own_wedding.id)
    elsif @wedding_guests.count == 1
      redirect_to wedding_path(@wedding_guests.first.wedding.id)
    end
  end

  # GET /weddings/1
  # GET /weddings/1.json
  def show
    authorize @wedding

    unless current_user == @wedding.user
      @logged_in_guest = WeddingGuest.where(user_id: current_user.id).first
    end

    @wedding_guests = @wedding.wedding_guests
    @languages = Language.get_language_hash(@wedding)

    if current_user == @wedding.user
      @pages = Page.where(wedding_id: @wedding.id).order("sort_order ASC")
      @wedding_description = @wedding.wedding_descriptions.first
    else
      @pages = @wedding.pages.where(language_id: current_user.language_id).order("sort_order ASC")
      @wedding_description = @wedding.wedding_descriptions.where(language_id: current_user.language_id).first
    end

    @invitation_texts = @wedding.invitation_texts
    @wedding_descriptions = @wedding.wedding_descriptions

  end

  # GET /weddings/new
  def new
    @languages = Language.all
    @wedding = Wedding.new

    authorize @wedding

    @weddings_languages = LanguagesWeddings.get_languages(@wedding)
  end

  # GET /weddings/1/edit
  def edit
    authorize @wedding


    @languages = Language.all
    @weddings_languages = LanguagesWeddings.get_languages(@wedding)
  end

  # POST /weddings
  # POST /weddings.json
  def create
    @wedding = Wedding.new(wedding_params)
    authorize @wedding

    @wedding.user = current_user

    respond_to do |format|
      if @wedding.save
        languages = params[:languages]
        languages.each do |language_id|
          wedding_language = LanguagesWeddings.new({:language => Language.find(language_id.to_i), :wedding => @wedding})
          wedding_language.save

          InvitationText.create({wedding_id: @wedding.id, language_id: language_id, front_body: "", back_body: ""})
          WeddingDescription.create({wedding_id: @wedding.id, language_id: language_id, body: ""})
        end

        format.html { redirect_to @wedding, notice: 'Wedding was successfully created.' }
        format.json { render :show, status: :created, location: @wedding }
      else
        format.html { render :new }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weddings/1
  # PATCH/PUT /weddings/1.json
  def update
    authorize @wedding

    languages = params[:languages]

    @wedding.languages.clear
    languages.each do |language_id|
      wedding_language = LanguagesWeddings.new({:language => Language.find(language_id.to_i), :wedding => @wedding})
      wedding_language.save
    end

    respond_to do |format|
      if @wedding.update(wedding_params)
        format.html { redirect_to @wedding, notice: 'Wedding was successfully updated.' }
        format.json { render :show, status: :ok, location: @wedding }
      else
        format.html { render :edit }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weddings/1
  # DELETE /weddings/1.json
  def destroy
    authorize @wedding

    @wedding.destroy
    respond_to do |format|
      format.html { redirect_to weddings_url, notice: 'Wedding was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def accept_wedding_invite
    wedding_guest = WeddingGuest.where(user_id: current_user.id).where(wedding_id: @wedding.id).first
    if wedding_guest
      wedding_guest.accepted = true
      wedding_guest.url = ""
      wedding_guest.short_token = ""
      wedding_guest.save

      respond_to do |format|
       format.html { redirect_to @wedding, notice: t("coming") }
       format.json { head :no_content }
      end
    else
      redirect_to root_path, notice: t("not_invited")
    end
  end

  def deny_wedding_invite
    wedding_guest = WeddingGuest.where(user_id: current_user.id).where(wedding_id: @wedding.id).first
    if wedding_guest
      wedding_guest.accepted = false
      wedding_guest.url = ""
      wedding_guest.short_token = ""
      wedding_guest.save

      respond_to do |format|
       format.html { redirect_to weddings_url, notice: t("not_coming") }
       format.json { head :no_content }
      end
    else
      redirect_to root_path, notice: t("not_invited")
    end
  end

  def print_invitations
    languages = LanguagesWeddings.get_languages(current_user.weddings.first)
    @dears = Hash.new
    @you_strings = Hash.new
    @urls = Hash.new

    languages.each do |language|
      @dears[language.id] = t("dear", :locale => language.tag)
      @you_strings[language.id] = {"singularis" => t("singularis", :locale => language.tag), "pluralis" => t("pluralis", :locale => language.tag)}
      if language.tag == "da"
        @urls[language.id] = "http://lisaogemil.dk"
      else
        @urls[language.id] = "http://lisaochemil.se"
      end
    end

    @invitation_texts = InvitationText.where(wedding_id: current_user.weddings.first.id).index_by(&:language_id)
    @wedding_guests = WeddingGuest.where(wedding_id: current_user.weddings.first.id)

    if @wedding_guests.nil?
      redirect_to root_path, notice: t("no_guests")
    end
  end

  def as_guest
    @wedding = Wedding.find(params[:wedding_id])
    @pages = Page.where(wedding_id: params[:wedding_id]).where(language_id: params[:language_id])
  end

  def playlist
    @wedding = Wedding.find(params[:wedding_id])

    @wedding_guests = @wedding.wedding_guests
    @languages = Language.get_language_hash(@wedding)

    if current_user == @wedding.user
      @pages = Page.where(wedding_id: @wedding.id).order("sort_order ASC")
      @wedding_description = @wedding.wedding_descriptions.first
    else
      @pages = @wedding.pages.where(language_id: current_user.language_id).order("sort_order ASC")
      @wedding_description = @wedding.wedding_descriptions.where(language_id: current_user.language_id).first
    end

    if @wedding.playlist_id.nil?
      return redirect_to user_omniauth_authorize_path(:spotify)
    end

    RSpotify.authenticate('', '')

    @spotify_user = RSpotify::User.new(@wedding.spotify_hash)

    playlists = @spotify_user.playlists

    playlists.each do |playlist|
      if playlist.id == @wedding.playlist_id
        @playlist = playlist
      end
    end
  end

  def add_song
    RSpotify.authenticate('', '')
    @wedding = Wedding.find(params[:wedding_id])
    track = RSpotify::Track.find(params[:song_id])
    tracks = [track]
    @spotify_user = RSpotify::User.new(@wedding.spotify_hash)
    @playlist = RSpotify::Playlist.find(@wedding.spotify_name, @wedding.playlist_id)
    @playlist.add_tracks!(tracks)

    render :json => {:status => :ok}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wedding
      @wedding = Wedding.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wedding_params
      params.require(:wedding).permit(:title, :description, :wedding_date, :user_id, :image, :remote_image_url)
    end
end
