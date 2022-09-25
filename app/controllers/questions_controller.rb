class QuestionsController < ApplicationController
  def new
    @training = Training.find(params[:training_id])
    @question = Question.new
    @choice = Choice.new
  end

  def show
  end
end
