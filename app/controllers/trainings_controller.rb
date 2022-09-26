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

  def show
    @training = Training.find(params[:id])
    # @question = @training.questions
  end

  private
    def training_params
      params.require(:training).permit(:title, :url)
    end
end
