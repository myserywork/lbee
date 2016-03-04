class CreateUserTransations < ActiveRecord::Migration
  def change
    create_table :user_transations do |t|
      t.integer :user_id
      t.integer :type
      t.float :price
      t.string :local
      t.string :key1
      t.string :key2
      t.string :status
      t.boolean :confirmed
      t.integer :admin_id

      t.timestamps null: false
    end
  end
end
