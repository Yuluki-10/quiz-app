class QuestionsController < ApplicationController
  before_action :authenticate_user!

  # GET) クイズ作成ページ
  def new
    @training = Training.find(params[:training_id])
    @chapter = Chapter.find(params[:chapter_id])
    @question = Question.new
    # 選択肢を4つ作成できるようにbuildする
    4.times do
      @question.choices.build
    end
  end

  # POST) クイズの作成
  def create
    @chapter = Chapter.find(params[:chapter_id])
    @training = @chapter.training

    correct_index = params[:question][:choices_attributes][:is_answer] # 「正解」とした選択肢が、どの番号か取得する
    params[:question][:choices_attributes]["#{correct_index}"][:is_answer] = true # 選択肢を「正解」に設定する
    @question = Question.new(question_params)
    if @question.save
      redirect_to training_chapter_path(@training, @chapter), notice: "問題を作成しました"
    else
      flash[:alert] = @question.errors.full_messages.join("\n")
      redirect_back(fallback_location: root_path) # 前のページに戻る
    end
  end

  # POST) ユーザーが問題に答える
  def answer
    @chapter = Chapter.find(params[:chapter_id])
    @training = @chapter.training

    # 選んだ選択肢が、問題の数分なければバリデーション
    questions_size = @chapter.questions - @chapter.questions.current_user_answered(current_user.id)
    unless params[:user_answer].permit!.to_hash.size == questions_size.size
      flash[:notice] = "全て答えを選んでください"
      redirect_back(fallback_location: root_path)
      return
    end

    params[:user_answer].each do |d|
      q_id = d[0].delete("choice_id_").to_i # "choice_id_問題番号"として格納されているので、問題番号以外の文字列を削除し、数値化する
      c_id = d[1] # ユーザーがどの選択肢を選んだか
      ua = UserAnswer.find_or_initialize_by(user_id: current_user.id, question_id: q_id)
      ua.update(choice_id: c_id)
    end

    # そのトレーニングの全ての問題に答えたかを判定する
    training_chapter_questions_size = 0
    current_user_answered_size = 0
    @training.chapters.includes(:questions).each do |tc|
      training_chapter_questions_size += tc.questions.size
      current_user_answered_size += tc.questions.current_user_answered(current_user.id).size
    end

    # 全てに回答済みなら、user_training_achievementを1足す?
    if training_chapter_questions_size == current_user_answered_size
      uta = UserTrainingAchievement.find_or_initialize_by(user_id: current_user.id, training_id: @training.id)
      uta.increment(:achievement_times, 1)
      uta.save

    end

    redirect_to result_training_chapter_questions_path(@training, @chapter)
  end

  # GET) 回答後の、ユーザーごとの結果ページ。トレーニングごとに作成
  def result
    @chapter = Chapter.find(params[:chapter_id])
    @training = @chapter.training
    @questions = Question.where(chapter_id: params[:chapter_id]).includes(:choices, :user_answers).order(number: "ASC")
    @user_choices = UserAnswer.where(user_id: current_user.id)
  end

  # GET) クイズの編集ページ
  def edit
    @chapter = Chapter.find(params[:chapter_id])
    @training = @chapter.training
    @question = Question.find(params[:id])
  end

  # PATCH) クイズの編集
  def update
    @chapter = Chapter.find(params[:chapter_id])
    @training = @chapter.training
    @question = Question.find(params[:id])

    # 全ての選択肢の正誤をfalseにリセットする。
    # [0..3]だとそのままRangeクラスになってしまう（=> [0..3]）。[*0..3]だと連番のArrayになる（=> [0, 1, 2, 3]）。
    [*0..3].each do |i|
      params[:question][:choices_attributes]["#{i}"][:is_answer] = false
    end

    # createの時と同様の処理
    correct_index = params[:question][:choices_attributes][:is_answer]
    params[:question][:choices_attributes]["#{correct_index}"][:is_answer] = true

    if @question.update(question_params)
      redirect_to training_chapter_path(@training, @chapter), notice: "問題を編集しました"
    else
      flash[:alert] = "編集できませんでした"
      return render :edit
    end
  end

  private
    def question_params
      params.require(:question).permit(
        :chapter_id,
        :number,
        :content,
        choices_attributes: [:id, :content, :is_answer, :_destroy] # :idを渡さないと、accepts_nested_attributes_forで入れ子になる値の編集更新ができない
      )
    end
end
