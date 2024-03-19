class WeddingGuest < ActiveRecord::Base
  belongs_to :user
  belongs_to :wedding


  def self.users(wedding)
    wedding_guests = WeddingGuest.where(wedding_id: wedding.id)

    user_ids = Array.new
    wedding_guests.each do |wedding_guest|
      user_ids.push(wedding_guest.user.id)
    end
    return user_ids
  end


end
