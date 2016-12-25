require 'sinatra'
require 'econfig'

#configure based on environment

class TimeTravelerAPI < Sinatra::Base
  extend Econfig::Shortcut
  Shoryuken.configure_server do |config|
    config.aws = {
      access_key_id:      config.AWS_ACCESS_KEY_ID,
      secret_access_key:  config.AWS_SECRET_ACCESS_KEY,
      region:             config.AWS_REGION
    }
    end
  API_VER = 'api/v0.1'

  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..', settings.root)
    Skyscanner::SkyscannerApi.config.update(skyscanner_id: config.SKYSCANNER_API)
    Airbnb::AirbnbApi.config.update(airbnb_id: config.AIRBNB_API)
    Google::GoogleApi.config.update(googlemap_id: config.GOOGLE_API)
  end

  get '/?' do
    "TimeTravelerAPI latest version endpoints are at: /#{API_VER}/"
  end
end
