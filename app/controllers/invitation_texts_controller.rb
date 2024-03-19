class InvitationTextsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_invitation_text, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @invitation_texts = InvitationText.all
    authorize @invitation_texts
    respond_with(@invitation_texts)
  end

  def show
    authorize @invitation_text
    respond_with(@invitation_text)
  end

  def new
    @invitation_text = InvitationText.new
    authorize @invitation_text
    respond_with(@invitation_text)
  end

  def edit
    authorize @invitation_text
    @languages = Language.get_language_hash (@invitation_text.wedding)
  end

  def create
    @invitation_text = InvitationText.new(invitation_text_params)
    authorize @invitation_text
    @invitation_text.wedding_id = current_user.wedding.id
    @invitation_text.save
    redirect_to weddings_path
  end

  def update
    authorize @invitation_text
    @invitation_text.update(invitation_text_params)
    redirect_to weddings_path
  end

  def destroy
    authorize @invitation_text
    @invitation_text.destroy
    respond_with(@invitation_text)
  end

  private
    def set_invitation_text
      @invitation_text = InvitationText.find(params[:id])
    end

    def invitation_text_params
      params.require(:invitation_text).permit(:wedding_id, :language_id, :back_body, :front_body, :single_front_body, :single_back_body)
    end
end
