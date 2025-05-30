class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end
  
  private
  
  def set_user
    # Protección contra ids no válidos
    if !params[:id].match?(/^\d+$/)
      redirect_to root_path, alert: 'User not found'
      return
    end
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'User not found'
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end