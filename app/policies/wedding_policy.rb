class WeddingPolicy < ApplicationPolicy
  attr_reader :user, :wedding

  def initialize(user, wedding)
    @user = user
    @wedding = wedding
  end

  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end

  def new?
    user.admin? && user.weddings.empty?
  end

  def create?
    user.admin? && user.weddings.empty?
  end

  def show?
    wedding.user == user || WeddingGuest.users(wedding).include?(user.id)
  end

  def edit?
    return wedding.user == user
  end

  def update?
    return wedding.user == user
  end

  def destroy?
    return wedding.user == user
  end
end
