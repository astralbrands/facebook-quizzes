class FacebookController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :login

  def login
    @quiz = Quiz.first
    redirect_to quiz_path(@quiz)
  end
end