class TrainingsController < ApplicationController
  def index
    @trainings = Training.all
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

  # GET) 個別トレーニングページ
  def show
    @training = Training.find(params[:id])
    @questions = @training.questions.order(number: "ASC")
    @user_answer = UserAnswer.new
  end


  private
    def training_params
      params.require(:training).permit(:title, :url, :categories)
    end
end
