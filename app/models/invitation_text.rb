class InvitationText < ActiveRecord::Base
  belongs_to :wedding
  belongs_to :language


  def self.policy_class
    InvitationTextPolicy
  end
end
