require 'sinatra'
require 'econfig'
require 'Time_Traveler'

class Time_TravelerAPI < Sinatra::Base
	extend Econfig::Shortcut
	  	Econfig.env = settings.environment.to_s
	  	Econfig.root = settings.root
	  	Google::GoogleApi
	    	.config
	    	.update(googlemap_id: config.GOOGLE_API)
	  	Airbnb::AirbnbApi
	  		.config
	  		.update(airbnb_id: config.AIRBNB_API)

	  	API_VER = 'api/v0.1.48'

		get '/?' do
	    	"Time_Traveler latest version endpoints are at: /#{API_VER}/"
	end

	get "/#{API_VER}/rent/:location/?" do
			location = params[:location]
			begin
				rent = Airbnb::RentInfo.find(location: location)
				content_type 'application/json'
				{
					location: rent.location,
					infos: rent.infos,
				}.to_json
			rescue
				halt 404, "Cannot find the location"
			end
	end

	get "/#{API_VER}/traffic/:origins/:destinations/:mode/?" do
			origins = params[:origins]
			destinations = params[:destinations]
			mode = params[:mode]
			begin
				traffic = Google::TrafficInfo.find(origins: origins, destinations: destinations, mode: mode)
				content_type 'application/json'
				{
					origins: traffic.origins,
					destinations: traffic.dest,
					mode: traffic.mode,
				}.to_json
			rescue
				halt 404, "Cannot return data"
			end
	end
end
