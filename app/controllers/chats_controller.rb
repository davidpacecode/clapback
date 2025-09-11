class ChatsController < ApplicationController
  def new
    @chat = Chat.new
  end

  def create
    @chat = Current.user.chats.create!
    user_message = params[:chat][:content] # Note: params[:chat][:content] not params[:content]
    # @response = @chat.ask(user_message)
    @response = @chat.ask_with_context(user_message)
    redirect_to @chat
  end

  def show
    @chat = Current.user.chats.find(params[:id])
  end

  def update
    @chat = Current.user.chats.find(params[:id])
    user_message = params[:chat][:content]
    # @response = @chat.ask(user_message)
    @response = @chat.ask_with_context(user_message)
    redirect_to @chat
  end

  def ask_with_context(user_message)
    context = build_context_from_responses

    chat.complete(
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

  def format_context(context_docs)
    context_docs.map do |doc|
      "Document #{doc[:metadata][:id]}:\nQuestion: #{doc[:metadata][:question]}\nCategory: #{doc[:metadata][:category]}\nContent: #{doc[:content]}\n\n"
    end.join
  end

  private

  def chat_params
    params.require(:chat).permit(:content)
  end
end

#  def new
#    @chat = Chat.new
#    @chat.messages.build # Build the first message
#  end
#
#  def create
#    @chat = Current.user.chats.build(chat_params)
#
#    if @chat.save
#      first_message = @chat.messages.first
#      ProcessMessageJob.perform_later(first_message) if first_message
#      redirect_to @chat
#    else
#      @message = Message.new
#      render :new, status: :unproccessable_entity
#    end
#  end
#
#  def show
#    @chat = Current.user.chats.find(params[:id])
#    @message = Message.new
#  end
#
#  private
#
#  def chat_params
#    params.require(:chat).permit(:model_id)
#  end
#
