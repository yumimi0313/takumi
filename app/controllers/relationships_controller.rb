class RelationshipsController < ApplicationController
  #cancancan読み込みのメソッド
  load_and_authorize_resource
  before_action :authenticate_user!
  
  def create
    @user = User.find(relationship_params[:followed_id])
    current_user.follow!(@user)
    # リダイレクト先を設定
    redirect_path = if @user.craftman.present?
                      craftman_path(@user.craftman)
                    elsif @user.candidate.present?
                      candidate_path(@user.candidate)
                    else
                      user_path(@user)
                    end
    respond_to do |format|
      format.html { redirect_to redirect_path }
      format.js
    end
  end
  
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
        # リダイレクト先を設定
    redirect_path = if @user.craftman.present?
                      craftman_path(@user.craftman)
                    elsif @user.candidate.present?
                      candidate_path(@user.candidate)
                    else
                      user_path(@user)
                    end
    respond_to do |format|
      format.html { redirect_to redirect_path }
      format.js
    end
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followed_id)
  end
end
