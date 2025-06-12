class MessagesController < ApplicationController
  load_and_authorize_resource
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Message.all
    @users = User.where(id: @messages.pluck(:user_id).uniq)
  end

  def show
    @user = User.find(@message.user_id)
    @chat = @message.chat
  end

  def new
    @message = Message.new
    @chats = Chat.all
    @users = User.all
  end
  
  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to @message, notice: 'Message was successfully created.'
    else
      @chats = Chat.includes(:sender, :receiver).all
      @users = User.all
      render :new
    end
  end

  def edit
    @message = Message.find(params[:id])
    @chats = Chat.includes(:sender, :receiver).all
    @users = User.all
  end

  def update
    if @message.update(message_params)
      redirect_to @message, notice: 'Message was successfully updated.'
    else
      @chats = Chat.all
      @users = User.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy
    redirect_to messages_path, notice: 'Message was successfully destroyed.'
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:chat_id, :user_id, :body)
  end
end