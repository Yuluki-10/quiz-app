class ChaptersController < ApplicationController
  before_action :authenticate_user!

  # GET) 「チャプター」作成ページ
  def new
    @training = Training.find(params[:training_id])
    @chapter = Chapter.new
  end

  # POST) 「チャプター」の作成
  def create
    @training = Training.find(params[:training_id])

    @chapter = Chapter.new(chapter_params)
    if @chapter.save
      redirect_to training_path(@training), notice: "チャプターが作成しました"
    else
      flash[:alert] = @chapter.errors.full_messages.join("\n")
      redirect_back(fallback_location: root_path) # 前のページに戻る
    end
  end

  # GET) 「チャプター」ページ
  def show
    @chapter = Chapter.find(params[:id])
    @training = @chapter.training
    @answered_questions = @chapter.questions.current_user_answered(current_user.id).includes(:choices, :user_answers).order(number: "ASC")
    @questions = @chapter.questions.unanswered(current_user.id).includes(:user_answers).order(number: "ASC") - @answered_questions
    @user_answer = UserAnswer.new

  end

  # GET) 「チャプター」の編集ページ
  def edit
    @training = Training.find(params[:training_id])
    @chapter = Chapter.find(params[:id])
  end

  # PATCH) 「チャプター」の編集
  def update
    @training = Training.find(params[:training_id])
    @chapter = Chapter.find(params[:id])

    if @chapter.update(chapter_params)
      if @chapter.errors.any?
        flash.now[:alert] = @chapter.errors.full_messages.join("\n")
        render :new
      else
        flash[:notice] = "チャプターが編集されました"
        redirect_to training_chapter_path(@training, @chapter)
      end
    else
      flash[:alert] = @chapter.errors.full_messages.join("\n")
      redirect_back(fallback_location: root_path) # 前のページに戻る
    end
  end

  private
  def chapter_params
    params.require(:chapter).permit(:training_id, :chapter_title, :url, :chapter_num, :content)
  end
end
