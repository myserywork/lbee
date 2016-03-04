class CreateFriendInvites < ActiveRecord::Migration
  def change
    create_table :friend_invites do |t|
      t.integer :user_id
      t.integer :friend_id
      t.string :invite_token

      t.timestamps null: false
    end
  end
end
