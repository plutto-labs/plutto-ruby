require 'plutto'
require 'simplecov'
require 'pry'

formatters = [SimpleCov::Formatter::HTMLFormatter]

if ENV['CI'] == 'true'
  require 'codecov'
  formatters << SimpleCov::Formatter::Codecov
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter::new(formatters)
end

SimpleCov.start do
  enable_coverage :branch
  add_filter { |src| !(src.filename =~ /lib/) }
  add_filter "spec.rb"
end

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
