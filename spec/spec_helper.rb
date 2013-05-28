require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  require "rails/application"
  require File.expand_path("../dummy/config/environment", __FILE__)
  require 'rspec/rails'
  require 'shoulda/matchers/integrations/rspec'
  require 'rspec/autorun'
  require 'database_cleaner'
  require 'capybara/rspec'
  require 'capybara/webkit'# if ENV['WEBKIT']

  Capybara.javascript_driver = :webkit
  

  require 'coveralls'
  Coveralls.wear!
  
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.use_transactional_fixtures = true
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.infer_base_class_for_anonymous_controllers = false
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run focus: true
    config.order = "random"
    config.run_all_when_everything_filtered = true
    
    config.before(:each) do
      DatabaseCleaner.strategy = :truncation #example.metadata[:js] ? :truncation : :transaction
      DatabaseCleaner.start
    end
    
    config.after(:each) do
      DatabaseCleaner.clean
    end
    
  end
end

Spork.each_run do
  ActiveSupport::Dependencies.clear
end