require 'simplecov'

formatters = [SimpleCov::Formatter::HTMLFormatter]

if ENV['CI'] == 'true'
  require 'codecov'
  formatters << SimpleCov::Formatter::Codecov
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter::new(formatters)
end

SimpleCov.start do
  enable_coverage :branch
  add_filter '/spec/'
end

require 'plutto'
require 'pry'
require 'vcr'
require 'factory_bot_rails'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options = {
    re_record_interval: 3600 * 24 * 70
  }
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
end

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].each do |file|
  require file
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
