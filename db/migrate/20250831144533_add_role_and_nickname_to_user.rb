class AddRoleAndNicknameToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :string, default: 'member'
    add_column :users, :nickname, :string
  end
end
