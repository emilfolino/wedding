class QandasController < ApplicationController

  def wedding_qanda
    @wedding = Wedding.find(params[:wedding_id])
    @pages = @wedding.pages.where(language_id: current_user.language_id).order("sort_order ASC")
    @qandas = Qanda.indexed_qandas(@wedding)
  end

  def create
    @qanda = Qanda.new(qanda_params)

    authorize @qanda

    @qanda.user = current_user

    if @qanda.parent_id.nil?
      @qanda.parent_id = 0
    end

    authorize @qanda
    respond_to do |format|
      if @qanda.save
        format.html { redirect_to wedding_qanda_path(@qanda.wedding), notice: t("qanda_success") }
        # format.json { render :show, status: :created, location: @gift }
      else
        format.html { redirect_to wedding_qanda_path(@qanda.wedding), notice: t("qanda_failure") }
        # format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def qanda_params
      params.require(:qanda).permit(:body, :wedding_id, :parent_id)
    end
end
