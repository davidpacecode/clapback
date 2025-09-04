class ChatsController < ApplicationController
  def new
    @chat = Chat.new
    @message = Message.new
  end

  def create
    @chat = Current.user.chats.build(chat_params)

  if @chat.save
    redirect_to @chat
  else
    @message = Message.new
    render :new, status: :unproccessable_entity
  end
  end

  def show
    @chat = Current.user.chats.find(params[:id])
    @message = Message.new
  end

  private

  def chat_params
    params.require(:chat).permit(:model_id)
  end
end
