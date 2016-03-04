class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :send_by
      t.integer :message_channel_id

      t.timestamps null: false
    end
  end
end
