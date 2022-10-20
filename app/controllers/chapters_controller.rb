class ChaptersController < ApplicationController

  # GET) 「チャプター」作成ページ
  def new
    @training = Training.find(params[:training_id])
    @chapter = Chapter.new
  end

  # POST) 「チャプター」の作成
  def create
    @training = Training.find(params[:training_id])

    @chapter = Chapter.create(chapter_params)
    if @chapter.errors.any?
      flash.now[:alert] = @chapter.errors.full_messages.join("\n")
      render :new
    else
      flash[:notice] = "チャプターが作成されました"
      redirect_to training_path(@training)
    end
  end

  # GET) 「チャプター」ページ
  def show
    @training = Training.find(params[:training_id])
    @chapter = Chapter.find(params[:id])
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
    end
  end

  private
  def chapter_params
    params.require(:chapter).permit(:training_id, :chapter_title, :url, :chapter_num, :content)
  end
end
