class GiftPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end

  attr_reader :user, :language

  def initialize(user, language)
    @user = user
    @language = language
  end

  def index?
    return false
  end

  def show?
    return false
  end

  def new?
    return false
  end

  def create?
    return false
  end

  def edit?
    return false
  end

  def update?
    return false
  end

  def delete?
    return false
  end
end