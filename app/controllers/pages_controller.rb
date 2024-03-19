class PagesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all
    authorize @pages
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    authorize @page
    @wedding = @page.wedding
    @pages = @wedding.pages.where(language_id: current_user.language_id).order("sort_order ASC")
  end

  # GET /pages/new
  def new
    @languages = Language.where(:id => current_user.weddings.first.languages)
    @page = Page.new

    authorize @page

    @sort_order = Hash.new
    @sort_order[t("choose_sort_order")] = 99
    page_count = current_user.weddings.first.pages.count + 1
    (1..page_count).each do |i|
      @sort_order[t(i.to_s + "th")] = i
    end
  end

  # GET /pages/1/edit
  def edit
    authorize @page

    @sort_order = Hash.new
    @sort_order[t("choose_sort_order")] = 99


    page_count = current_user.weddings.first.pages.count


    (1..page_count).each do |i|
      @sort_order[t(i.to_s + "th")] = i
    end

    @languages = Language.where(:id => current_user.weddings.first.languages)
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    authorize @page
    @page.wedding_id = current_user.weddings.first.id
    @page.language_id = params[:language_id].to_i
    @page.sort_order = params[:sort_order].to_i
    @page.imageurl = params[:imageurl].to_s

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    @page.language_id = params[:language_id].to_i
    @page.sort_order = params[:sort_order].to_i
    @page.imageurl = params[:imageurl].to_s

    authorize @page
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    authorize @page
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:page_title, :page_body, :wedding_id, :language_id, :sort_order, :imageurl)
    end
end
