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

  # def answer
  #   @training = Training.find(params[:training_id])
  #   @question = Question.find(params[:id])
  #   choice_number = params[:user_answer][:answer].to_i - 1
  #   if @question.choices[choice_number].is_answer == true
  #     #params[:answer]-1番目の,@question.choicesのis_answerがtrueなら正解
  #     ua = UserAnswer.find_or_initialize_by(user_id: current_user.id, question_id: params[:id])
  #     ua.update(result: true)
  #     flash[:notice] = "#{choice_number}は正解です"
  #   else
  #     ua = UserAnswer.find_or_initialize_by(user_id: current_user.id, question_id: params[:id])
  #     ua.update(result: false)
  #     flash[:notice] = "#{choice_number}は不正解です"
  #   end
  #   redirect_to training_path(@training)
  # end

  def show
  end

  private
    def question_params
      params.require(:question).permit(
        :training_id,
        :content,
        choices_attributes: [:content, :is_answer, :_destroy]
      )
    end
end
