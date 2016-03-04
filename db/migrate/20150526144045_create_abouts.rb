class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.string :title
      t.text :about_desc
      t.string :about_img

      t.timestamps null: false
    end
  end
end
