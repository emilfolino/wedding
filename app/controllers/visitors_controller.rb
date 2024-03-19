class VisitorsController < ApplicationController
  def accept_user_invitation
    wedding_quest = WeddingGuest.where(short_token: params[:short_token]).first

    if wedding_quest
      url = wedding_quest.url
      redirect_to url
    else
      redirect_to root_path, :alert => "Hittade inte gästen"
    end
  end
end