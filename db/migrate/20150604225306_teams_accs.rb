class TeamsAccs < ActiveRecord::Migration
  def change
    add_column :teams, :acc_fb, :string
    add_column :teams, :acc_twitter, :string
    add_column :teams, :acc_ig, :string
    add_column :teams, :acc_tube, :string
    add_column :teams, :acc_twitch, :string
    add_column :teams, :acc_steam, :string
  end
end
