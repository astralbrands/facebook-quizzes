class QuestionsController < ApplicationController
  def create
    quiz = Quiz.from_param params[:quiz_id]
    question = quiz.questions.create(question_params)
    redirect_to edit_quiz_url(quiz) 
  end

  def show
    @question = Question.find params[:id]
    @quiz = @question.quiz
  end

  def respond
    @question = Question.find params[:id]
    @quiz = @question.quiz
    @answer = @question.answers.find{|a| a.category_id == params[:answer_id].to_i }
    @category = @answer.category
    session["question_#{params[:id]}"] = @category.id
    next_question = @quiz.questions.find{|q| q.sequence == @question.sequence + 1 }
    redirect_to quiz_question_path id: next_question.id and return unless @quiz.last?(@question)
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
    @question.answers.each(&:delete)
    @question.destroy
    redirect_to edit_quiz_url(@quiz)
  end

  private
    def question_params
      params.require(:question).permit(:text, :weight, :sequence)
    end
end