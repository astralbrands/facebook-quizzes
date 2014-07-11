class FacebookController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :login

  def login
    @quiz = Quiz.first
    redirect_to redirect_path(@quiz)
  end

  private

    def redirect_path(quiz)
      quiz.nil? ? "/quizzes/new" : quiz_path(quiz)
    end
end