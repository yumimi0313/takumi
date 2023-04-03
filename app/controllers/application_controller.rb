class ApplicationController < ActionController::Base
   require "openai"
   require "dotenv"
   Dotenv.load

  before_action:set_common_variable
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
  end

  private
  def set_common_variable
     @client = OpenAI::Client.new(access_token: ENV["CHATGPT_API_KEY"])
   end
end
