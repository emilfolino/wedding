class CreateInvitationTexts < ActiveRecord::Migration
  def change
    create_table :invitation_texts do |t|
      t.references :wedding, index: true
      t.references :language, index: true
      t.text :body

      t.timestamps
    end
  end
end
