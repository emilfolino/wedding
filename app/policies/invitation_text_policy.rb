class InvitationTextPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end

  attr_reader :user, :invitation_text

  def initialize(user, invitation_text)
    @user = user
    @invitation_text = invitation_text
  end

  def index?
    return false
  end

  def show?
    return false
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def edit?
    user == invitation_text.wedding.user
  end

  def update?
    user == invitation_text.wedding.user
  end

  def delete?
    user == invitation_text.wedding.user
  end
end
