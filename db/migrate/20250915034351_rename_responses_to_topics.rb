class RenameResponsesToTopics < ActiveRecord::Migration[8.0]
  def change
    rename_table :responses, :topics
    rename_column :topics, :response, :messaging
  end
end
