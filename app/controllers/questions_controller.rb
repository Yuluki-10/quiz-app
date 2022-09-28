class QuestionsController < ApplicationController

  def new
    @training = Training.find(params[:training_id])
    @question = Question.new
    4.times do
      @question.choices.build
    end
  end

  def create
    @training = Training.find(params[:training_id])
    @question = Question.new(question_params)
    if @question.save
      redirect_to trainings_path, notice: "問題を作成しました"
    else
      flash.now[:alert] = @question.errors.full_messages.join("\n")
      render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
    end
  end

  # POST) ユーザーが問題に答える
  def answer
    @training = Training.find(params[:training_id])

    params[:user_answer].each do |d|
      # binding.pry
      q_id = d[0].delete("choice_id_").to_i
      c_id = d[1]
      UserAnswer.find_or_create_by(user_id: current_user.id, question_id: q_id, choice_id: c_id)
    end

    redirect_to result_training_questions_path(@training)
  end

  # GET) 回答後の、ユーザーごとの結果ページ。トレーニングごとに作成
  def result
    @training = Training.find(params[:training_id])
    @questions = Question.where(training_id: params[:training_id]).includes(:choices, :user_answers)
    @user_choices = UserAnswer.where(user_id: current_user.id)
    # binding.pry
  end


  private
    def question_params
      params.require(:question).permit(
        :training_id,
        :number,
        :content,
        choices_attributes: [:content, :is_answer, :_destroy]
      )
    end
end
