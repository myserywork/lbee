class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :subtitle
      t.string :img_url
      t.text :news_text
      t.integer :game_id

      t.timestamps null: false
    end
  end
end
