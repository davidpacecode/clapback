class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])

    # Create and persist the user message immediately
    @chat.create_user_message(params[:content])

    ChatStreamJob.perform_later(@chat.id)

    respond_to do |format|
      format.turbo_stream { head :ok }
      format.html { redirect_to @chat }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
