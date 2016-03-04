class UserCurrentToken < ActiveRecord::Migration
  def change
    add_column :users, :app_access_token, :string
  end
end
