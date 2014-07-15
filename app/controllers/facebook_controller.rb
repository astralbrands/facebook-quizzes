class FacebookController < ApplicationController
  force_ssl unless Rails.env.development?

  skip_before_filter :verify_authenticity_token, only: :login
  after_filter :allow_iframe

  def login
    @quiz = Quiz.first
    redirect_to redirect_path(@quiz)
  end

  private

    def redirect_path(quiz)
      quiz.nil? ? "/quizzes/new" : quiz_path(quiz)
    end

    def allow_iframe
      response.headers.except! ["X-Frame-Options"]
    end
end