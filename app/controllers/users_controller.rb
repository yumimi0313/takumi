class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password) 
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    unless current_user == @user
      redirect_to root_path, alert: "他のユーザーの情報にアクセスすることはできません。"
    end
  end
end
