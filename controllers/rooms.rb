# frozen_string_literal: true

# TimeTravelerAPI web service
class TimeTravelerAPI < Sinatra::Base
      location = params[:location]
      begin
        rent = Airbnb::RentInfo.find(location: location)

      # Get each room's info
      rent.infos.each do |room|
        room_id = room.id
        room_name = room.name
        room_address = room.address
        room_airbnb_link = room.airbnb_link
        room_roomImg = room.roomImg
        room_bed = room.bed
        room_roomRank = room.roomRank
      end

      # Shown on the broswer
      content_type 'application/json'
      {
        location: rent.location,
        infos: rent.infos
        infos: rooms_info
      }.to_json

      rescue
        halt 404, "Cannot find the location"
      end

    rescue
      halt 404, "Cannot find the location"
    end
  end
end 
