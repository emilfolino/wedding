class QandaPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end

  attr_reader :user, :qanda

  def initialize(user, qanda)
    @user = user
    @qanda = qanda
  end

  def create?
    WeddingGuest.users(qanda.wedding).include?(user.id) || user.admin?
  end
end