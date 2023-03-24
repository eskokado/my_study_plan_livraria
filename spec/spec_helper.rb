require 'rspec/json_expectations'
require 'rspec-json_matchers'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

require File.expand_path('../../config/environment', __FILE__)
RSpec.configure do |config|
  config.include RSpec::JsonMatchers::Matchers
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

RspecApiDocumentation.configure do |config|
  config.docs_dir = Rails.root.join('doc', 'api')
  config.format = [:html]
end
