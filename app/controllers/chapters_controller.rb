class ChaptersController < ApplicationController

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
    @questions = @chapter.questions.order(number: "ASC")
    # @user_answer = []
    # @questions.each do |q|
    #   if ua = UserAnswer.find_by(user_id: current_user.id, question_id: q.id)
    #     # 回答済みの問題に、回答済みフラグを立てる?
    #     @user_answer.push(ua)
    #   else
    #     @user_answer.push(UserAnswer.new)
    #   end
    # end
    @user_answer = UserAnswer.new
    # binding.pry
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
