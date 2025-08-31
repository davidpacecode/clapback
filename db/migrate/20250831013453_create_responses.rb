class CreateResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :responses do |t|
      t.text :question
      t.text :response
      t.text :tags
      t.string :category

      t.timestamps
    end
  end
end
