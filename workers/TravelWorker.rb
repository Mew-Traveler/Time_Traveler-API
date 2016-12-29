# frozen_string_literal: true
require 'econfig'
require 'shoryuken'
require_relative '../values/init.rb'
require_relative '../config/init.rb'
require_relative '../models/init.rb'
require_relative '../representers/init.rb'
require_relative '../services/init.rb'

class TravelWorker
  extend Econfig::Shortcut
  Econfig.env = ENV['RACK_ENV'] || 'development'
  Econfig.root = File.expand_path('..', File.dirname(__FILE__))
  Shoryuken.configure_client do |shoryuken_config|
    shoryuken_config.aws = {
      access_key_id:      TravelWorker.config.AWS_ACCESS_KEY_ID,
      secret_access_key:  TravelWorker.config.AWS_SECRET_ACCESS_KEY,
      region:             TravelWorker.config.AWS_REGION
    }
  end

  include Shoryuken::Worker
  shoryuken_options queue: config.TRAVELER_QUEUE, auto_delete: true

  def perform(_sqs_msg, body)
    puts "REQUEST: #{body}"
    rent = HTTP.get("https://api.airbnb.com/v2/search_results?client_id=3092nxybyb0otqw18e8nh5nty&location="+body)
    puts "---------#{rent.body}---------"
    rent.body.to_s
    # rent = Airbnb::RentInfo.find(location: body)
  end
end
