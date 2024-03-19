class AddSingleTextToInvitationTexts < ActiveRecord::Migration
  def change
    add_column :invitation_texts, :single_front_body, :text
    add_column :invitation_texts, :single_back_body, :text
  end
end
