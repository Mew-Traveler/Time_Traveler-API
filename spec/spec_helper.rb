# frozen_string_literal: true
# require 'simplecov'
# SimpleCov.start
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'
require 'rack/test'

# require 'yaml'
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

VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock

  c.filter_sensitive_data('<SKY_API_KEY>')  { ENV['SKY_API_KEY'] }
  c.filter_sensitive_data('<AIRBNB_CLIENT_ID>') { ENV['AIRBNB_CLIENT_ID'] }
end

HAPPY_MOVIE_URL = 'http://www.omdbapi.com?t=star+wars&y=&plot=short&r=json'
SAD_MOVIE_URL = 'http://www.omdbapi.com?t=sadmovie&y=&plot=short&r=json'

SAD_MOVIE = 'sadmovie'
SAD_LOCATION_ID = '0000'
REMOVED_LOCATION_ID = '0000'

# if File.file?('config/credentials.yml')
#   credentials = YAML.load(File.read('config/credentials.yml'))
#   ENV['AIRBNB_API'] = credentials[:airbnb_id]
#   ENV['GOOGLE_API'] = credentials[:googlemap_id]
#   ENV['SKYSCANNER_API'] = credentials[:skyscanner_id]
# end
#
# RESULT_FILE_AIRBNB = "#{FIXTURES_FOLDER}/airbnb_api_results.yml"
# RESULT_FILE_GOOGLEMAP = "#{FIXTURES_FOLDER}/googlemap_api_results.yml"
# RESULT_FILE_SKYSCANNER = "#{FIXTURES_FOLDER}/skyscanner_api_results.yml"
# AIRBNB_RESULT = YAML.load(File.read(RESULT_FILE_AIRBNB))
# GOOGLEMAP_RESULT = YAML.load(File.read(RESULT_FILE_GOOGLEMAP))
