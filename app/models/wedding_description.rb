class WeddingDescription < ActiveRecord::Base
  belongs_to :wedding
  belongs_to :language
end
