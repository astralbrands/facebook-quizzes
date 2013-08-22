class QuestionsController < ApplicationController
  def create
    quiz = Quiz.from_param params[:quiz_id]
    question = quiz.questions.create(question_params)
    redirect_to edit_quiz_url(quiz) 
  end

  def show
    @quiz = Quiz.from_param params[:quiz_id]
    @question = Question.find params[:id]
  end

  def respond
    @quiz = Quiz.from_param params[:quiz_id]
    @question = Question.find params[:id]
    @category = Answer.find(params[:answer_id]).category
    session["question_#{params[:id]}"] = @category.id
    redirect_to quiz_question_path id: (params[:id].to_i + 1) and return unless @quiz.last?(@question)
    redirect_to quiz_finish_path
  end

  def update
    @question = Question.find params[:id]
    @quiz = @question.quiz
    @question.update question_params
    @question.save
    redirect_to edit_quiz_url(@quiz)
  end

  def destroy
    @question = Question.find params[:id]
    @quiz = @question.quiz
    @question.answers.destroy
    @question.destroy
    binding.pry
    redirect_to edit_quiz_url(@quiz)
  end

  private
    def question_params
      params.require(:question).permit(:text)
    end
end
