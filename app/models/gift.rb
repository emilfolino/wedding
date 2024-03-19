class Gift < ActiveRecord::Base
  belongs_to :wedding
  belongs_to :user

  def self.policy_class
    GiftPolicy
  end

  def get_name (language_id)
    if self.name.split("|").count > 1
      self.name.split("|")[language_id]
    else
      self.name.chop
    end
  end
end
