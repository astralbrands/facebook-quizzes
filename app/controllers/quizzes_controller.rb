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

  def start
    @quiz = Quiz.from_param(params[:quiz_id])
    clear_session
    redirect_to @quiz.questions.first
  end

  def finish
    @quiz = Quiz.find_by_id params[:quiz_id]
    @category = @quiz.get_results(answers)
    redirect_to "/quizzes/#{@quiz.slug}/#{@category.slug}"
  end

  def result
    @quiz = Quiz.find_by_slug(params["slug"])
    unless redirect_to_start?
      @category = @quiz.categories.find_by_slug params["category_slug"]
      render template: "quizzes/finish"
    else
      redirect_to "https://apps.facebook.com/aloette-quizzes"
    end
  end

  private
    def redirect_to_start?
      is_facebook? || answers.length.zero?
    end

    def is_facebook?
      request.user_agent =~ /facebookexternalhit/ || request.user_agent =~ /Facebot/
    end

    def answers
      session.to_hash.keep_if{|k, v| k.match(/question/)}
    end

    def quiz_params
      params.require(:quiz).permit(:name, :intro, :title, :product_copy)
    end

    def clear_session
      session.to_hash.keep_if{|k, v| k =~ /question_/ }.each{|k, v| session.delete(k) }
    end
end