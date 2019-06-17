require 'bundler/setup'
require 'yaml'
require 'faraday'
require 'json'
require 'biilabs-client'

Bundler.setup

ENV['RAILS_ENV'] ||= 'test'

RSpec.configure do |config|
  # some (optional) config here
end
