$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ucb_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ucb_rails"
  s.version     = UcbRails::VERSION
  s.authors     = ["Steve Downey"]
  s.email       = ["steve.downtown@gmail.com"]
  s.homepage    = "https://github.com/stevedowney/ucb_rails"
  s.summary     = "Jumpstart a UCB Rails application."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.1"
  s.add_dependency "jquery-rails"
  
  s.add_dependency 'ucb_ldap', '2.0.0.pre1'
  s.add_dependency "omniauth"
  s.add_dependency "omniauth-cas"
  s.add_dependency "haml"
  s.add_dependency 'rails_environment'
  
  s.add_development_dependency "sqlite3"
  
  if ENV['ENGINE_DEVELOPER'] == 'true'
    s.add_development_dependency 'launchy'
    s.add_development_dependency 'better_errors'
    s.add_development_dependency 'binding_of_caller'
    s.add_development_dependency "redcarpet"
    s.add_development_dependency "yard"
    s.add_development_dependency 'quiet_assets'
    s.add_development_dependency 'thin'
  end
  
end
