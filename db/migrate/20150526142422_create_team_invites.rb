class CreateTeamInvites < ActiveRecord::Migration
  def change
    create_table :team_invites do |t|
      t.integer :team_id
      t.integer :user_id
      t.string :invite_token
      t.integer :sent_by

      t.timestamps null: false
    end
  end
end
