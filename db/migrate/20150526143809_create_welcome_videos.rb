class CreateWelcomeVideos < ActiveRecord::Migration
  def change
    create_table :welcome_videos do |t|
      t.string :name
      t.string :link
      t.string :duration

      t.timestamps null: false
    end
  end
end
