class Wedding < ActiveRecord::Base
  belongs_to :user
  has_many :pages
  mount_uploader :image, WeddingImageUploader
  has_and_belongs_to_many :languages
  has_many :invitation_texts
  has_many :wedding_guests
  has_many :qandas
  has_many :wedding_descriptions

  serialize :spotify_hash, Hash

  def self.policy_class
    WeddingPolicy
  end
end
