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

  def index
    @chats = Current.user.chats.all
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
