# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
FacebookQuizzes::Application.initialize!

Paperclip.options[:command_path] = ENV['IMAGEMAGICK_PATH']