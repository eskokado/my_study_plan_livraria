# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'

# require 'rails_helper'
require 'swagger_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Rswag::Specs::SwaggerFormatter.configure do |config|
#   config.swagger_root = Rails.root.to_s + '/swagger'
#   config.include_failure_examples = true
#   config.swagger_formatter_url = nil
# end

RSpec.configure do |config|
  config.after(:each, type: :request) do |example|
    example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

  # config.include RSpecApiDocumentation::DSL
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
