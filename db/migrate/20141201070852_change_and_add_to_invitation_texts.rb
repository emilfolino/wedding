class ChangeAndAddToInvitationTexts < ActiveRecord::Migration
  def change
    rename_column :invitation_texts, :body, :back_body
    add_column :invitation_texts, :front_body, :text
  end
end
