class UsersController < ApplicationController
  load_and_authorize_resource 

  def index
    @users = User.all
  end

  def show
   
  end

  def new
    
  end

  def create
    if @user.save
      redirect_to @user, notice: 'Usuario creado correctamente.'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end