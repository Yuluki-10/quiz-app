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

    redirect_to result_training_questions_path(@training)
  end

  # GET) 回答後の、ユーザーごとの結果ページ。トレーニングごとに作成
  def result
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
