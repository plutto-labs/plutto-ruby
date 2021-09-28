require_relative 'lib/plutto/version'

Gem::Specification.new do |spec|
  spec.name          = "plutto"
  spec.version       = Plutto::VERSION
  spec.authors       = ["Plutto", "Marco"]
  spec.email         = ["marco@platan.us"]
  spec.homepage      = "https://github.com/plutto-labs/plutto-ruby"
  spec.summary       = "The official Ruby library for the Plutto API."
  spec.description   = "This gem will help you easily integrate Plutto API to your software, making your developer life a little bit more enjoyable."
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.2.15"
  spec.add_development_dependency "codecov"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec_junit_formatter"
  spec.add_development_dependency "rubocop", "~> 1.9"
  spec.add_development_dependency "rubocop-rails"
  spec.add_development_dependency "pry"
end
