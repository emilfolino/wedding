class GiftsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_gift, only: [:show, :edit, :update, :destroy, :give]

  # GET /gifts
  # GET /gifts.json
  def index
    @gifts = Gift.all
    authorize @gifts
  end

  # GET /gifts/1
  # GET /gifts/1.json
  def show
    authorize @gift
  end

  # GET /gifts/new
  def new
    @gift = Gift.new
    authorize @gift
  end

  # GET /gifts/1/edit
  def edit
    authorize @gift
  end

  # POST /gifts
  # POST /gifts.json
  def create
    @gift = Gift.new
    @gift.name = params[:name].values.join("|")
    @gift.wedding_id = gift_params[:wedding_id]
    @gift.can_be_given_multiple = gift_params[:can_be_given_multiple]
    @gift.url = gift_params[:url]
    # authorize @gift

    respond_to do |format|
      if @gift.save
        format.html { redirect_to wedding_gifts_path(@gift.wedding_id), notice: 'Gift was successfully created.' }
        # format.json { render :show, status: :created, location: @gift }
      else
        format.html { render :new }
        # format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gifts/1
  # PATCH/PUT /gifts/1.json
  def update
    authorize @gift
    respond_to do |format|
      if @gift.update(gift_params)
        format.html { redirect_to wedding_gifts_path(@gift.wedding_id), notice: 'Gift was successfully updated.' }
        format.json { render :show, status: :ok, location: @gift }
      else
        format.html { render :edit }
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gifts/1
  # DELETE /gifts/1.json
  def destroy
    # authorize @gift

    wedding_id = @gift.wedding_id

    @gift.destroy
    respond_to do |format|
      format.html { redirect_to wedding_gifts_path(wedding_id), notice: 'Gift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def wedding_gifts
    @wedding = Wedding.find(params[:wedding_id])
    @gifts = Gift.where(wedding_id: params[:wedding_id])
    @pages = @wedding.pages.where(language_id: current_user.language_id).order("sort_order ASC")
    @languages = @wedding.languages
    language_ids = @wedding.languages.collect(&:id)
    unless current_user.admin?
      @language_index = language_ids.index(current_user.language_id)
    end

    authorize @gifts
  end

  def give
    if @gift.can_be_given_multiple
      if @gift.multiple_users.nil? || @gift.multiple_users.empty?
        str = current_user.name
      else
        str = @gift.multiple_users + ", " + current_user.name
      end

      @gift.update_attributes(:multiple_users => str)
    else
      @gift.update_attributes(:user => current_user)
    end

    respond_to do |format|
      format.html { redirect_to wedding_gifts_path(@gift.wedding_id), notice: t("you_give") + ": " + @gift.name }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gift
      @gift = Gift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gift_params
      params.require(:gift).permit(:name, :url, :wedding_id, :user_id, :can_be_given_multiple, :multiple_users)
    end
end
