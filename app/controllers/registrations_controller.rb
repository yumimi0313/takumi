# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController

  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def edit
    super
  end

  def update
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :email, :password, :password_confirmation])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role, :email, :password, :password_confirmation])
  end

  def after_sign_up_path_for(resource)
    if resource.role == 'craftman'
      new_craftman_path
    elsif resource.role == 'candidate'
      new_candidate_path
    end
  end
end