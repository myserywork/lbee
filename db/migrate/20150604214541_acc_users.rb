class AccUsers < ActiveRecord::Migration
  def change
    add_column :users, :acc_fb, :string
    add_column :users, :acc_twitter, :string
    add_column :users, :acc_ig, :string
    add_column :users, :acc_tube, :string
    add_column :users, :acc_twitch, :string
    add_column :users, :acc_steam, :string
  end
end
