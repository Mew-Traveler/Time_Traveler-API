# frozen_string_literal: true
ENV['RACK_ENV'] = 'development'

require 'minitest/autorun'
require 'minitest/rg'
require 'rack/test'
require 'vcr'
require 'webmock'

require './init.rb'

include Rack::Test::Methods

def app
  TimeTravelerAPI
end


if File.file?('config/app.yml')
  credentials = YAML.load(File.read('config/app.yml'))
  ENV['AIRBNB_API'] = credentials['development']['AIRBNB_API']
  ENV['GOOGLE_API'] = credentials['development']['GOOGLE_API']
  ENV['SKYSCANNER_API'] = credentials['development']['SKYSCANNER_API']
end

