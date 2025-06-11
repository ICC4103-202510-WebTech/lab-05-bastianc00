class MessagesController < ApplicationController
  load_and_authorize_resource  

  def index
    @messages = current_user.sent_messages
  end

  def show
    
  end

  def new
    @chats = current_user.chats
  end

  def create
    @message.user = current_user  
    if @message.save
      redirect_to @message, notice: 'Mensaje enviado.'
    else
      @chats = current_user.chats
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:chat_id, :body)
  end
end