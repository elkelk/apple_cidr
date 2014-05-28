ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

RSpec.configure do |config|
  config.order = "random"
  config.color_enabled = true

  config.include FactoryGirl::Syntax::Methods
  DatabaseCleaner.strategy = :truncation

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
