class AddUserTypeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_role, :int, default: 0
  end
end
