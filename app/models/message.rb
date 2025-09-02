class Message < ApplicationRecord
  acts_as_message
  has_many_attached :attachments  # Required for file attachments

  # These validations are fine:
  validates :role, presence: true
  validates :chat, presence: true
end
