class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update, :destroy]
  authorize_resource  

  def index
    @chats = current_user.sent_chats.or(current_user.received_chats)
  end

  def show
    authorize! :read, @chat 
  end

  def new
    @chat = current_user.sent_chats.build
    @users = User.where.not(id: current_user.id)
  end

  def create
    @chat = current_user.sent_chats.build(chat_params)
    if @chat.save
      redirect_to @chat, notice: 'Chat creado.'
    else
      @users = User.where.not(id: current_user.id)
      render :new
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:receiver_id)
  end
end