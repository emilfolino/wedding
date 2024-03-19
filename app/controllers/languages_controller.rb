class LanguagesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_language, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @languages = Language.all
    authorize @languages
    respond_with(@languages)
  end

  def show
    authorize @language
    respond_with(@language)
  end

  def new
    @language = Language.new
    authorize @language
    respond_with(@language)
  end

  def edit
    authorize @language
  end

  def create
    @language = Language.new(language_params)
    authorize @language
    flash[:notice] = 'Language was successfully created.' if @language.save
    respond_with(@language)
  end

  def update
    flash[:notice] = 'Language was successfully updated.' if @language.update(language_params)
    authorize @language
    respond_with(@language)
  end

  def destroy
    authorize @language
    @language.destroy
    respond_with(@language)
  end

  private
    def set_language
      @language = Language.find(params[:id])
    end

    def language_params
      params.require(:language).permit(:tag, :name)
    end
end
