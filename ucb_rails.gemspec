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
  s.add_dependency "haml-rails"
  s.add_dependency 'bootstrap-sass', '~> 2.3'
  s.add_dependency 'sass-rails', '~> 3.2'
  s.add_dependency 'active_attr'
  s.add_dependency 'simple_form', '~> 2.1.0'
  s.add_dependency "jquery-datatables-rails", "~> 1.11.2"
  s.add_dependency 'kaminari'
  

  s.add_dependency 'rails_environment'
  s.add_dependency 'bootstrap-view-helpers', '~> 0.0.13'
  s.add_dependency 'rails_view_helpers', '~> 0.0.2'
  s.add_dependency 'user_announcements', '~> 0.0.8'
  
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "capybara-webkit"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'shoulda-matchers'  
  s.add_development_dependency 'database_cleaner'
  
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
