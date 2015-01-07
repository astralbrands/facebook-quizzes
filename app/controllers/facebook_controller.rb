class FacebookController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :login
  after_filter :allow_iframe

  def login
    @quiz = Quiz.last
    redirect_to redirect_path(@quiz)
  end

  private

    def redirect_path(quiz)
      quiz.nil? ? "/quizzes/new" : quiz_path(quiz)
    end

    def allow_iframe
      response.headers["X-Frame-Options"] = "GOFORIT"
    end
end