class UsersController < ApplicationController
  #cancancan読み込みのメソッド
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def show
    @following = @user.following
    @followers = @user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password) 
  end

  def set_user
    @user = User.find(params[:id])
  end
end
