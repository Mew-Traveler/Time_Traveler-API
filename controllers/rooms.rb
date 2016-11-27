# frozen_string_literal: true

# TimeTravelerAPI web service
class TimeTravelerAPI < Sinatra::Base   
  get "/#{API_VER}/rent/:location/?" do
    location = params[:location]
    begin
      rent = Airbnb::RentInfo.find(location: location)
      content_type 'application/json'
      {
        location: rent.location,
        infos: rent.infos
      }.to_json

      rescue
        halt 404, "Cannot find the location"
      end
  end
end