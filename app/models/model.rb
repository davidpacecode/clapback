class Model < ApplicationRecord
  # Remove the serialize calls since json column type handles it
  validates :model_id, presence: true
  validates :name, presence: true
  validates :provider, presence: true
end
