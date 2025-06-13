class ChatsController < ApplicationController
  load_and_authorize_resource
  before_action :set_chat, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    @chats = Chat.for_user(current_user)
    @users = User.where(id: @chats.pluck(:sender_id, :receiver_id).flatten.uniq)
  end

  def show
    @sender = User.find(@chat.sender_id)
    @receiver = User.find(@chat.receiver_id)
    @messages = @chat.messages
  end

  def new
    @chat = Chat.new
    @users = User.all
  end
  
  def create
    @chat = Chat.new(chat_params)
    @chat.sender_id = current_user.id

    if @chat.save
      redirect_to @chat, notice: 'Chat was successfully created.'
    else
      @users = User.all
      render :new
    end
  end

  def edit
    #@chat = Chat.find(params[:id])
    @users = User.all
  end

  def update
    #@chat = Chat.find(params[:id])
    if @chat.update(chat_params)
      redirect_to @chat, notice: 'Chat was successfully updated.'
    else
      @users = User.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @chat.destroy
      redirect_to chats_path, notice: 'Chat and its messages were successfully deleted.'
    else
      redirect_to chats_path, alert: 'Could not delete the chat.'
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