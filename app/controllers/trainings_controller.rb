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
    @user_answer = UserAnswer.new
  end

  def answer
    @training = Training.find(params[:id])

    params[:user_answer].each do |d|
      # binding.pry
      q_id = d[0].delete("answer_").to_i
      question = Question.find(q_id)
      choice_number = d[1].to_i - 1
      if question.choices[choice_number].is_answer == true
        #params[:answer]-1番目の,@question.choicesのis_answerがtrueなら正解
        ua = UserAnswer.find_or_initialize_by(user_id: current_user.id, question_id: q_id)
        ua.update(result: true)
      else
        ua = UserAnswer.find_or_initialize_by(user_id: current_user.id, question_id: q_id)
        ua.update(result: false)
      end
    end

    redirect_to training_path(@training)
  end

  private
    def training_params
      params.require(:training).permit(:title, :url)
    end
end
