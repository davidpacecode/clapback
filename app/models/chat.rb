class Chat < ApplicationRecord
  acts_as_chat

  belongs_to :user, optional: true

  broadcasts_to ->(chat) { [ chat, "messages" ] }

  def ask_with_context(user_message)
    context = build_context_from_responses

    complete(
      messages: [
        {
          role: "system",
          content: "You are a helpful assistant. Use the following context documents to answer questions:\n\n#{format_context(context)}"
        },
        {
          role: "user",
          content: user_message
        }
      ]
    )
  end

  def build_context_from_responses
    context_docs = []

    Response.includes(:rich_text_response).each do |response|
      context_docs << {
        content: response.response.to_plain_text, # Strips HTML formatting
        metadata: {
          id: response.id,
          question: response.question,
          category: response.category,
          tags: response.tag_list
        }
      }
    end

    context_docs
  end
end
