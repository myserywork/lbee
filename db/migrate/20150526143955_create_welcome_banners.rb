class CreateWelcomeBanners < ActiveRecord::Migration
  def change
    create_table :welcome_banners do |t|
      t.string :name
      t.string :img_url
      t.integer :game_id
      t.boolean :active

      t.timestamps null: false
    end
  end
end
