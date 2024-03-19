class Page < ActiveRecord::Base
  belongs_to :wedding


  def self.policy_class
    PagePolicy
  end
end
