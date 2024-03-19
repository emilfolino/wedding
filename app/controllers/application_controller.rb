class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_filter :export_i18n_messages

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def set_locale
    if current_user
      current_language = Language.where(id: current_user.language_id).first
      if current_language
        I18n.locale = current_language.tag || I18n.default_locale
      else
        I18n.locale = I18n.default_locale
      end
    else
      I18n.locale = I18n.default_locale
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:invite) << :name
    end

  private
    def user_not_authorized
      flash[:error] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

    def record_not_found
      flash[:error] = "No no, you were not supposed to be there."
      redirect_to root_path
    end

    def export_i18n_messages
      SimplesIdeias::I18n.export! if Rails.env.development?
    end
end
