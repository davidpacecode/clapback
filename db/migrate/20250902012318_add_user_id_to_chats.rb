class AddUserIdToChats < ActiveRecord::Migration[8.0]
  def change
    add_reference :chats, :user, null: false, foreign_key: true
  end
end
