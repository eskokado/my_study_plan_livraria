# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require 'rake'
require 'swagger/docs/rails'
require 'swagger/docs/rake_task'
require_relative "config/application"

Swagger::Docs::Task.new do |t|
  t.swagger_config = "#{Rails.root}/config/initializers/swagger_docs.rb"
end

Rails.application.load_tasks

