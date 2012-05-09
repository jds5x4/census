$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "census/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "census"
  s.version     = Census::VERSION
  s.authors     = ["Joshua Smith"]
  s.email       = ["jsmith@addsheet.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Census."
  s.description = "Get Census like date"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_runtime_dependency "acts_as_list", "= 0.1.5"
  s.add_runtime_dependency "inverse_of", ">= 0.0.1"
  s.add_runtime_dependency 'formtastic', '~> 2.2'
  s.add_development_dependency "rspec-rails", "~> 2.5"
  s.add_development_dependency "capybara"
  s.add_development_dependency "shoulda", ">= 0"
  s.add_development_dependency "factory_girl_rails", ">= 0"
end
