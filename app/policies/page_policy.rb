class PagePolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end

  attr_reader :user, :page

  def initialize(user, page)
    @user = user
    @page = page
  end

  def index?
    return false
  end

  def show?
    page.wedding.user == user || WeddingGuest.users(page.wedding).include?(user.id)
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def edit?
    user == page.wedding.user
  end

  def update?
    user == page.wedding.user
  end

  def delete?
    user == page.wedding.user
  end
end