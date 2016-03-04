class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :tag
      t.string :website
      t.string :password
      t.string :about
      t.integer :game_id
      t.string :img_logo
      t.string :img_cover
      t.string :token_confirmation
      t.boolean :active

      t.timestamps null: false
    end
  end
end
