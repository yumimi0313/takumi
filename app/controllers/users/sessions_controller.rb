# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def guest_admin_sign_in
    user = User.guest_admin
    sign_in user
    redirect_to user_path(current_user.id), notice: 'ゲスト管理者ユーザーとしてログインしました。'
  end

  def guest_craftman_sign_in
    user = User.guest_craftman
    sign_in user
    redirect_to user_path(current_user.id), notice: 'ゲスト匠（事業者）ユーザーとしてログインしました。'
  end

  def guest_candidate_sign_in
    user = User.guest_candidate
    sign_in user
    redirect_to user_path(current_user.id), notice: 'ゲスト後継候補者ユーザーとしてログインしました。'
  end
end
