class CandidatesController < ApplicationController
  #cancancan読み込みのメソッド
  load_and_authorize_resource
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  # GET /candidates
  def index
    @q = Candidate.ransack(params[:q])
    @candidates = @q.result(distinct: true).order("created_at desc")
  end

  # GET /candidates/1
  def show
    @user = @candidate.user
    @q = Candidate.ransack(params[:q]) 
  end

  # GET /candidates/new
  def new
    @candidate = Candidate.new
  end

  # GET /candidates/1/edit
  def edit
  end

  # POST /candidates
  def create
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      redirect_to @candidate, notice: '候補書を登録しました'
    else
      render :new
    end
  end

  # PATCH/PUT /candidates/1
  def update
    if @candidate.update(candidate_params)
      redirect_to @candidate, notice: '候補者を更新しました'
    else
      render :edit
    end
  end

  # DELETE /candidates/1
  def destroy
    @candidate.destroy
    redirect_to candidates_url, notice: 'Candidate was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def candidate_params
      params.require(:candidate).permit(:user_id, :name, :interested_category, :wanted_technology, :prefecture, :profile, images: [])
    end
end
