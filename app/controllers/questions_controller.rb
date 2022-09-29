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
    correct_index = params[:question][:choices_attributes][:is_answer]
    # binding.pry
    params[:question][:choices_attributes]["#{correct_index}"][:is_answer] = true

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
      q_id = d[0].delete("choice_id_").to_i
      c_id = d[1]
      ua = UserAnswer.find_or_initialize_by(user_id: current_user.id, question_id: q_id)
      ua.update(choice_id: c_id)
    end

    redirect_to result_training_questions_path(@training)
  end

  # GET) 回答後の、ユーザーごとの結果ページ。トレーニングごとに作成
  def result
    @training = Training.find(params[:training_id])
    @questions = Question.where(training_id: params[:training_id]).includes(:choices, :user_answers).order(number: "ASC")
    @user_choices = UserAnswer.where(user_id: current_user.id)
  end

  def edit
    @training = Training.find(params[:training_id])
    @question = Question.find(params[:id])
  end

  def update
    @training = Training.find(params[:training_id])
    @question = Question.find(params[:id])

    # 全ての選択肢の正誤をfalseにリセットする
    [*0..3].each do |i|
      params[:question][:choices_attributes]["#{i}"][:is_answer] = false
    end

    correct_index = params[:question][:choices_attributes][:is_answer]
    params[:question][:choices_attributes]["#{correct_index}"][:is_answer] = true

    if @question.update(question_params)
      redirect_to trainings_path, notice: "問題を編集しました"
    else
      flash.now[:alert] = @question.errors.full_messages.join("\n")
      render :edit, alert: "編集できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
    end
  end

  private
    def question_params
      params.require(:question).permit(
        :training_id,
        :number,
        :content,
        choices_attributes: [:id, :content, :is_answer, :_destroy] # :idを渡さないと、accepts_nested_attributes_forで入れ子になる値の編集更新ができない
      )
    end
end
