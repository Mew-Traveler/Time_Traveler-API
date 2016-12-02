# frozen_string_literal: true

# TimeTravelerAPI web service
class TimeTravelerAPI < Sinatra::Base   
  get "/#{API_VER}/rent/:location/?" do
    location = params[:location]
    begin
      rent = Airbnb::RentInfo.find(location: location)

      # Get each room's info
      # rent.infos.each do |room|
      #   room_id = room[:id]
      #   room_name = room[:name]
      #   room_address = room[:address]
      #   room_airbnb_link = room[:airbnb_link]
      #   room_roomImg = room[:roomImg]
      #   room_bed = room[:bed]
      #   room_roomRank = room[:roomRank]
      # end

      # Shown on the broswer
      content_type 'application/json'
      {
        location: location,
        infos: rent.infos
      }.to_json


    rescue
      halt 404, "Cannot find the location~~~"
    end
  end
end