class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :country
      t.string :email
      t.date :birthdate
      t.string :primary_game
      t.string :nick_name
      t.string :encrypted_password
      t.string :salt
      t.string :img_avatar
      t.date :last_login
      t.integer :login_count
      t.integer :age
      t.string :my_resume
      t.string :titles
      t.string :token_confirmation
      t.boolean :active
      t.string :token_reset_confirmation

      t.timestamps null: false
    end
  end
end
