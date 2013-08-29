class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:answer][:question_id])
    content, category = answer_params.values
    @answer = @question.answers.create(content: content, category_id: category)
    redirect_to edit_quiz_path(@answer.question.quiz)    
  end

  def destroy
    @answer = Answer.find params[:id]
    @answer.destroy
    redirect_to edit_quiz_path(@answer.question.quiz)
  end

  def update
    @answer = Answer.find params[:id]
    @answer.update update_params
    redirect_to edit_quiz_path(@answer.question.quiz)
  end

  private
    def answer_params
      params.require(:answer).permit(:content, :category, :sequence)
    end

    def update_params
      params.require(:answer).permit(:content, :sequence)
    end
end
