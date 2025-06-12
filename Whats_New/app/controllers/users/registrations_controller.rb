# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  protected

  # Parámetros permitidos para el registro
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, 
      keys: [
        :first_name, 
        :last_name,
        :avatar,
        # Agrega aquí otros campos personalizados
      ])
  end

  # Parámetros permitidos para actualización
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, 
      keys: [
        :first_name, 
        :last_name,
        :avatar,
        :current_password
        # Agrega aquí otros campos personalizados
      ])
  end

  # Ruta después del registro exitoso
  def after_sign_up_path_for(resource)
    root_path # Cambia esto según tus necesidades
  end

  # Ruta después de actualización exitosa
  def after_update_path_for(resource)
    user_path(resource) # Cambia esto según tus necesidades
  end
end