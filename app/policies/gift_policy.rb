class GiftPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end

  attr_reader :user, :gift

  def initialize(user, gift)
    @user = user
    @gift = gift
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
    user == gift.wedding.user
  end

  def update?
    user == gift.wedding.user
  end

  def destroy?
    user == gift.wedding.user
  end

  def give?
    WeddingGuest.users(gift.wedding).include?(user.id)
  end

  def wedding_gifts?
    if user.admin?
      return true
    else
      if gift.nil? || gift.empty?
        return true
      else
        gift.each do |g|
          WeddingGuest.users(g.wedding).include?(user.id)
        end
      end
    end
  end
end