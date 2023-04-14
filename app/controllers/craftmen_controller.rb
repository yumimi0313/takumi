class CraftmenController < ApplicationController
  before_action :set_craftman, only: [:show, :edit, :update, :destroy]

  # GET /craftmen
  def index
    @q = Craftman.ransack(params[:q])
    @craftmen = @q.result(distinct: true).order("created_at desc")
  end

  # GET /craftmen/1
  def show
    @user = @craftman.user
    @q = Craftman.ransack(params[:q]) 
  end

  # GET /craftmen/new
  def new
    @craftman = Craftman.new
  end

  # GET /craftmen/1/edit
  def edit
  end

  # POST /craftmen
  def create
    @craftman = Craftman.new(craftman_params)

    if @craftman.save
      redirect_to @craftman, notice: 'Craftman was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /craftmen/1
  def update
    if @craftman.update(craftman_params)
      redirect_to @craftman, notice: 'Craftman was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /craftmen/1
  def destroy
    @craftman.destroy
    redirect_to craftmen_url, notice: 'Craftman was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_craftman
      @craftman = Craftman.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def craftman_params
      params.require(:craftman).permit(:user_id, :category, :company_name, :prefecture, :manicipal, :recruit_status, :recruit_title, :recruit_content, :profile, :history, :technology, images: [])
    end
end
