class CreateTeamPermissions < ActiveRecord::Migration
  def change
    create_table :team_permissions do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
