class ChatsController < ApplicationController
  def new
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
