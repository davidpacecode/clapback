class Chat < ApplicationRecord
  acts_as_chat

  belongs_to :user, optional: true

  broadcasts_to ->(chat) { [ chat, "messages" ] }

  def ask_with_context(user_message)
    context = build_context_from_messaging

    # Format the context directly here
    formatted_context = context.map do |doc|
      "Document #{doc[:metadata][:id]}:\nQuestion: #{doc[:metadata][:question]}\nCategory: #{doc[:metadata][:category]}\nContent: #{doc[:content]}\n\n"
    end.join

    # Create the enhanced user message with context
    enhanced_message = "Context:\n#{formatted_context}\n\nUser Question: #{user_message}"

    # Use the simple ask method with the enhanced message
    ask(enhanced_message)
  end

  private

  def build_context_from_messaging
    context_docs = []

    Topic.includes(:rich_text_messaging).each do |topic|
      # Skip if no rich text content
      next unless topic.messaging.present?

      content = topic.messaging.to_plain_text&.strip
      next if content.blank?

      context_docs << {
        content: content,
        metadata: {
          id: topic.id,
          question: topic.question || "No question",
          category: topic.category || "Uncategorized",
          tags: topic.tag_list || []
        }
      }
    end

    context_docs
  end
end
