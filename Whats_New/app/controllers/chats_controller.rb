class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @chats = current_user.chats.includes(:sender, :receiver, :messages)
  end

  def show
    @message = Message.new
  end

  def new
    @chat = Chat.new
    @users = User.all_except(current_user)
  end

  def create
    @chat = current_user.sent_chats.build(chat_params)
    if @chat.save
      redirect_to @chat, notice: 'Chat creado correctamente.'
    else
      @users = User.all_except(current_user)
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