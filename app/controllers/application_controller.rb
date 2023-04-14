class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  #セキュリティ攻撃を防ぐための設定
  protect_from_forgery with: :exception

  # #Userログイン後の設定
  def after_sign_in_path_for(resource)
    if resource.role == 'craftman'
      new_craftman_path
    elsif resource.role == 'candidate'
      new_candidate_path
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
  end
end
