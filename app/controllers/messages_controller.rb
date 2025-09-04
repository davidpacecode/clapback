class MessagesController < ApplicationController
  def create
    # claude said this but docs said next line @chat = Current.user.chats.find(params[:chat_id])
    @chat = Chat.find(params[:chat_id])
    # claude said this but docs said next line @message = @chat.messages.build(message_params.merge(role: "user"))
    @chat.create_user_message(params[:content])

      # if @message.save
      # process the LLM response asynchronously
      # claude said this but docs said next line ProcessMessageJob.perform_later(@message)
      ChatStreamJob.perform_later(@chat.id)
      # clade said this but docs said below redirect_to @chat

      respond_to do |format|
        format.turbo_stream { head :ok }
        format.html { redirect_to @chat }
      end
    # else
    #  render "chat/show", status: :unprocessable_entity
    # end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
