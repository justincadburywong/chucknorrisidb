require 'rubygems'
require 'webmock/rspec'

# All our specs should require 'spec_helper' (this file)

# If RACK_ENV isn't set, set it to 'test'.  Sinatra defaults to development,
# so we have to override that unless we want to set RACK_ENV=test from the
# command line when we run rake spec.  That's tedious, so do it here.
ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

 # Webmock.disable_net_connect!(allow_localhost: true) 

 RSpec.configure do |config|
   config.before(:each) do
     stub_request(:get, /api.icndb.com/).
       with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
       to_return(status: 200, body: "stubbed response", headers: {})
   end
 end
