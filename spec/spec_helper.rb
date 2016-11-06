# frozen_string_literal: true
<<<<<<< HEAD
ENV['RACK_ENV'] = 'test'
require 'simplecov'
SimpleCov.start
=======
#require 'simplecov'
#SimpleCov.start
>>>>>>> 76c67876775a0a5e7794fc21b51d96eb421a06bc

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock'

require_relative '../app'
include Rack::Test::Methods

def app
	Time_TravelerAPI
end
require_relative '../lib/Time_Traveler'

FIXTURES_FOLDER = 'spec/fixtures'
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"
CASSETTE_FILE_GOOGLE = 'google_distances'
CASSETTE_FILE_AIRBNB = 'airbnb_rooms'

if File.file?('config/credentials.yml')
  credentials = YAML.load(File.read('config/credentials.yml'))
  ENV['AIRBNB_API'] = credentials[:airbnb_id]
  ENV['GOOGLE_API'] = credentials[:googlemap_id]
end

RESULT_FILE_AIRBNB = "#{FIXTURES_FOLDER}/airbnb_api_results.yml"
RESULT_FILE_GOOGLEMAP = "#{FIXTURES_FOLDER}/googlemap_api_results.yml"
# AIRBNB_RESULT = YAML.load(File.read(RESULT_FILE_AIRBNB))
# GOOGLEMAP_RESULT = YAML.load(File.read(RESULT_FILE_GOOGLEMAP))

VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<AIRBNB_ID>') {ENV['AIRBNB_API'] }
    c.filter_sensitive_data('<GOOGLEMAP_ID>') {ENV['GOOGLE_API'] }
end
