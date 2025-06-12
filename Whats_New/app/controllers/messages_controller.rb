class MessagesController < ApplicationController
  load_and_authorize_resource

  def create
    @message = current_user.messages.build(message_params)
    @message.chat_id = params[:chat_id]

    if @message.save
      redirect_to chat_path(@message.chat), notice: 'Mensaje enviado.'
    else
      redirect_to chat_path(@message.chat), alert: 'Error al enviar el mensaje.'
    end
  end

  def destroy
    @message.destroy
    redirect_to chat_path(@message.chat), notice: 'Mensaje eliminado.'
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end