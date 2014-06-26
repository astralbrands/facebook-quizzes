# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

FacebookQuizzes::Application.load_tasks

spec = Gem::Specification.find_by_name 'proviso'
load "#{spec.gem_dir}/lib/tasks/provisioning.rake"