class User < ActiveRecord::Base
  attr_reader :raw_invitation_token

  has_many :weddings, dependent: :destroy
  has_many :qandas
  has_many :gifts

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:spotify]


  def self.from_omniauth(auth)
    # where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #   user.email = auth.info.email
    #   user.password = Devise.friendly_token[0,20]
    #   user.name = auth.info.name   # assuming the user model has a name
    #   user.image = auth.info.image # assuming the user model has an image
    # end
  end
end
