# frozen_string_literal: true
# require 'simplecov'
# SimpleCov.start
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'
require 'rack/test'
require 'vcr'
require 'webmock'
require './init.rb'

# require_relative '../lib/Time_Traveler'
include Rack::Test::Methods

def app
  TimeTravelerAPI
end

FIXTURES_FOLDER = 'spec/fixtures'
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"
CASSETTE_FILE_GOOGLE = 'google_distances'
CASSETTE_FILE_AIRBNB = 'airbnb_rooms'
CASSETTE_FILE_SKYSCANNER = 'skyscanner_flights'
CASSETTE_FILE_USER = 'userdata'
CASSETTE_FILE_PROJECT = 'projectdata'

VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock

  c.filter_sensitive_data('<SKYSCANNER_API>')  { ENV['SKYSCANNER_API'] }
  c.filter_sensitive_data('<GOOGLE_API>') { ENV['GOOGLE_API'] }
  c.filter_sensitive_data('<AIRBNB_API>') { ENV['AIRBNB_API'] }

end
