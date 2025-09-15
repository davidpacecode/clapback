class Topic < ApplicationRecord
  has_rich_text :messaging  # Use Action Text for formatting
  has_one_attached :attachment  # Active Storage for PDFs

  def tag_list
    tags.split(",").map(&:strip) if tags.present?
  end
end
