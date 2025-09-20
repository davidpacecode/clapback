class ChatsController < ApplicationController
  def new
    @chat = Chat.new
  end

  def create
    @chat = Current.user.chats.create!
    user_message = params[:chat][:content] # Note: params[:chat][:content] not params[:content]
    # @topic = @chat.ask(user_message)
    @topic = @chat.ask_with_context(user_message)
    @chat.set_name_from_first_message! # Auto-set name
    redirect_to @chat
  end

  def show
    @chat = Current.user.chats.find(params[:id])
  end

  def edit
    @chat = Current.user.chats.find(params[:id])
  end

  def update
    @chat = Current.user.chats.find(params[:id])

    # Check if this is a name update (for inline editing)
    if params[:chat][:name].present?
      if @chat.update(name: params[:chat][:name])
        redirect_to @chat, notice: "Chat name updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    # Otherwise, this is a new message
    elsif params[:chat][:content].present?
      user_message = params[:chat][:content]
      @topic = @chat.ask_with_context(user_message)
      redirect_to @chat
    else
      redirect_to @chat, alert: "No content provided"
    end
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
