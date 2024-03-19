class Users::InvitationsController < Devise::InvitationsController

  def new
    @wedding = current_user.weddings.first

    @languages = LanguagesWeddings.get_languages(@wedding)

    super
  end

  def edit
    @new_user = User.find_by(email: resource.email)
    current_language = Language.where(id: @new_user.language_id).first
    if current_language
      I18n.locale = current_language.tag || I18n.default_locale
    else
      I18n.locale = I18n.default_locale
    end
  end

  def create
    @wedding = current_inviter.weddings.first

    new_user = User.find_by(email: invite_resource.email)
    new_user.name = params[:name]
    new_user.invitation_sent_at = DateTime.now
    new_user.language_id = params[:language].to_i
    new_user.save

    short_token = create_short_token(new_user)
    url = accept_user_invitation_url(:invitation_token => invite_resource.raw_invitation_token)

    WeddingGuest.create(user_id: new_user.id, wedding_id: @wedding.id, url: url, short_token: short_token)

    respond_with resource, :location => new_user_invitation_path
  end

  def after_invite_path_for(resource)
    root_path
  end


  private
  # this is called when creating invitation
  # should return an instance of resource class
  def invite_resource
    ## skip sending emails on invite
    resource_class.invite!(invite_params, current_inviter) do |u|
      u.skip_invitation = true
    end
  end

  def create_short_token (user)
    return URI::escape(user.name.downcase.gsub(/[^0-9a-z]/i, '')) + user.id.to_s + Random.rand(0...10).to_s
  end
end