class CreateBamUsers < ActiveRecord::Migration
  def change
    create_table :bam_users do |t|
      t.integer :user_bam
      t.integer :user_id
      t.string :message

      t.timestamps null: false
    end
  end
end
