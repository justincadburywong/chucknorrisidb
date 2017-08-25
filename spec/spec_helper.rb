require 'coveralls'
Coveralls.wear!
require 'rubygems'
require 'webmock/rspec'
require 'database_cleaner'
require 'rack/test'


# All our specs should require 'spec_helper' (this file)

# If RACK_ENV isn't set, set it to 'test'.  Sinatra defaults to development,
# so we have to override that unless we want to set RACK_ENV=test from the
# command line when we run rake spec.  That's tedious, so do it here.
ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

# Webmock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) { DatabaseCleaner.start }
  config.after(:each)  { DatabaseCleaner.clean }
end

def app
  Sinatra::Application.new
end
