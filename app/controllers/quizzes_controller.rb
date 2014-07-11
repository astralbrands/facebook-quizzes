class QuizzesController < ApplicationController
  def new
    @quiz = Quiz.new
  end

  def index
    @quizzes = Quiz.all
  end

  def edit
    @quiz = Quiz.from_param(params[:id])
    @question = Question.new
    @answer = Answer.new
    @category = Category.new
  end

  def update
    @quiz = Quiz.from_param params[:id]
    @quiz.update quiz_params
    @quiz.save!
    redirect_to edit_quiz_url(@quiz)
  end

  def show
    @quiz = Quiz.from_param params[:id]
  end

  def create
    quiz = Quiz.create(quiz_params)
    quiz.save!
    redirect_to edit_quiz_url(quiz)
  end

  def finish
    @quiz = Quiz.from_param params[:quiz_id]
    answers = session.to_hash.keep_if{|k, v| k.match(/question/)}
    @category = @quiz.get_results(answers)
    redirect_to "/quizzes/#{@quiz.id}/#{@category.slug}"
  end

  def result
    @quiz = Quiz.find_by_slug(params["slug"])
    @category = @quiz.categories.find_by_slug params["category_slug"]
    render template: "quizzes/finish"
  end

  private
    def quiz_params
      params.require(:quiz).permit(:name, :intro, :title, :product_copy)
    end
end