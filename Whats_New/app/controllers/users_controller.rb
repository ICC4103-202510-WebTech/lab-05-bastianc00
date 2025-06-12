class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all_except(current_user).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Perfil actualizado correctamente.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar)
  end
end