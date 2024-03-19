class AddMultipleUsersToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :multiple_users, :string
  end
end
