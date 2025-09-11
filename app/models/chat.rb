class Chat < ApplicationRecord
  acts_as_chat

  belongs_to :user, optional: true

  broadcasts_to ->(chat) { [ chat, "messages" ] }

  def ask_with_context(user_message)
    context = build_context_from_responses

    # Format the context directly here
    formatted_context = context.map do |doc|
      "Document #{doc[:metadata][:id]}:\nQuestion: #{doc[:metadata][:question]}\nCategory: #{doc[:metadata][:category]}\nContent: #{doc[:content]}\n\n"
    end.join

    # Pass messages as a keyword argument
    complete(
      user_message,
      system_message: "You are a helpful assistant. Use the following context documents to answer questions:\n\n#{formatted_context}"
    )
  end

  private

  def build_context_from_responses
    context_docs = []

    Response.includes(:rich_text_response).each do |response|
      # Skip if no rich text content
      next unless response.response.present?

      content = response.response.to_plain_text&.strip
      next if content.blank?

      context_docs << {
        content: content,
        metadata: {
          id: response.id,
          question: response.question || "No question",
          category: response.category || "Uncategorized",
          tags: response.tag_list || []
        }
      }
    end

    context_docs
  end
end
