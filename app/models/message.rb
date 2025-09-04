class Message < ApplicationRecord
  acts_as_message
  has_many_attached :attachments  # Required for file attachments

  # These validations are fine:
  validates :role, presence: true
  validates :chat, presence: true

  broadcasts_to ->(message) { [ message.chat, "messages" ] }

  # Helper to broadcast chunks during streaming
  def broadcast_append_chunk(chunk_content)
    broadcast_append_to [ chat, "messages" ], # Target the stream
      target: dom_id(self, "content"), # Target the content div inside the message frame
      html: chunk_content # Append the raw chunk
  end
end
