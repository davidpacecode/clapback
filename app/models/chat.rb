class Chat < ApplicationRecord
  acts_as_chat

  belongs_to :user, optional: true

  broadcasts_to ->(chat) { [ chat, "messages" ] }


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
