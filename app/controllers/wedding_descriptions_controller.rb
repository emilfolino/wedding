class WeddingDescriptionsController < ApplicationController
  before_action :set_wedding_description, only: [:show, :edit, :update, :destroy]

  # GET /wedding_descriptions
  # GET /wedding_descriptions.json
  def index
    @wedding_descriptions = WeddingDescription.all
  end

  # GET /wedding_descriptions/1
  # GET /wedding_descriptions/1.json
  def show
  end

  # GET /wedding_descriptions/new
  def new
    @wedding_description = WeddingDescription.new
  end

  # GET /wedding_descriptions/1/edit
  def edit
  end

  # POST /wedding_descriptions
  # POST /wedding_descriptions.json
  def create
    @wedding_description = WeddingDescription.new(wedding_description_params)

    respond_to do |format|
      if @wedding_description.save
        format.html { redirect_to @wedding_description, notice: 'Wedding description was successfully created.' }
        format.json { render :show, status: :created, location: @wedding_description }
      else
        format.html { render :new }
        format.json { render json: @wedding_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wedding_descriptions/1
  # PATCH/PUT /wedding_descriptions/1.json
  def update
    respond_to do |format|
      if @wedding_description.update(wedding_description_params)
        format.html { redirect_to @wedding_description.wedding, notice: 'Wedding description was successfully updated.' }
        format.json { render :show, status: :ok, location: @wedding_description }
      else
        format.html { render :edit }
        format.json { render json: @wedding_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wedding_descriptions/1
  # DELETE /wedding_descriptions/1.json
  def destroy
    @wedding_description.destroy
    respond_to do |format|
      format.html { redirect_to wedding_descriptions_url, notice: 'Wedding description was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wedding_description
      @wedding_description = WeddingDescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wedding_description_params
      params.require(:wedding_description).permit(:body, :wedding_id, :language_id)
    end
end
