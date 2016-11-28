$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'rspec/mocks'
require 'webmock/rspec'
require 'simplecov'
require 'options/api'

SimpleCov.start
WebMock.disable_net_connect!(allow: 'codeclimate.com')

RSpec.configure do |config|
  config.mock_with :rspec
end
