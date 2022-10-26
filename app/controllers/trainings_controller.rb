class TrainingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # GET) トレーニング一覧
  def index
    @trainings = Training.includes(chapters: [questions: [:user_answers]]).all
  end

  # GET) トレーニング作成ページ
  def new
    @training = Training.new
  end

  # POST) トレーニング作成
  def create
    @training = Training.create(training_params)
    if @training.errors.any?
      flash.now[:alert] = @training.errors.full_messages.join("\n")
      render :new
    else
      flash[:notice] = "トレーニングが作成されました"
      redirect_to trainings_path
    end
  end

  # GET) トレーニングページ
  def show
    @training = Training.includes(chapters: [questions: [:user_answers]]).find(params[:id])
  end

  # GET) トレーニング編集ページ
  def edit
    @training = Training.find(params[:id])
  end

  # PATCH) トレーニングの編集
  def update
    if training = Training.find(params[:id])
      @training = training.update(training_params)
      flash[:notice] = "トレーニングを編集しました"
      redirect_to training_path
    else
      return redirect_to trainings_path
    end
  end

  # GET)マイページ
  def mypage
    @user_training_achievements = UserTrainingAchievement.where(user_id: current_user.id)
  end

  private
    def training_params
      params.require(:training).permit(:title, :categories)
    end
end
