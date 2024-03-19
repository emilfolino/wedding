class AddCanBeGivenMultipleToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :can_be_given_multiple, :boolean
  end
end
