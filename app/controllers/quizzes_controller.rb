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
    redirect_to "/#{@quiz.slug}_#{@category.slug}"
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

  def retake
    @quiz = Quiz.last
    redirect_to @quiz
  end

  private
    def redirect_to_start?
      return false if Rails.env.development?
      return false if is_facebook?
      return true if has_answers?
      return false
    end

    def is_facebook?
      return true if request.user_agent =~ /facebookexternalhit/
      return true if request.user_agent =~ /Facebot/
      return false
    end

    def has_answers?
      answers.length.zero?
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