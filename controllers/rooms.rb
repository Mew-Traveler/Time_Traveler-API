# frozen_string_literal: true

# TimeTravelerAPI web service
class TimeTravelerAPI < Sinatra::Base
  # get the data from airbnb api with the location
  get "/#{API_VER}/rent/:location/?" do
    location = params[:location]
    begin
      # res = TravelWorker.perform_async("taipei",quere:'soaq')
      res = Shoryuken::Client.queues('soaq').send_message(location)
      puts "----------WORKER: #{res}----------"

      rent = Airbnb::RentInfo.find(location: location)

      # Get each room's info
      rent.infos.each do |room|
        room_id = room[:id]
        room_name = room[:name]
        room_address = room[:address]
        room_airbnb_link = room[:airbnb_link]
        room_roomImg = room[:roomImg]
        room_bed = room[:bed]
        room_roomRank = room[:roomRank]
      end

      # Shown on the broswer
      content_type 'application/json'
      {
        location: location,
        infos: rent.infos
      }.to_json


    rescue
      halt 404, "Cannot find the location"
    end
  end

  # get the house data from database
  get "/#{API_VER}/house/:room_id/?" do
    begin
      id = params[:room_id]
      house = House.find(roomId: id)
      content_type 'application/json'
      {
        roomId: house.roomId,
        roomName: house.roomName,
        roomPrice: house.roomPrice,
        address: house.address,
        airbnb_link: house.airbnb_link,
        roomImg: house.roomImg,
        bed: house.bed,
        roomRank: house.roomRank
      }.to_json

    rescue
      content_type 'text/plain'
      halt 404, "Cannot find house (roomId: #{id}"
    end
  end

  # generate data for testing
  post "/#{API_VER}/house1/generate/test/?" do
    begin
      House.create(
        roomId: "1234",
        roomName: "This is room name test",
        roomPrice: "test price",
        address: "test address",
        airbnb_link: "test link",
        roomImg: "test roomImg",
        bed: "3",
        roomRank: "5"
        )

      content_type 'application/json'
      {
        roomId: "1234",
        roomName: "This is room name test",
        roomPrice: "test price",
        address: "test address",
        airbnb_link: "test link",
        roomImg: "test roomImg",
        bed: "3",
        roomRank: "5"
      }.to_json

    rescue
      content_type 'text/plain'
      halt 500, "Cannot create house for testing"
    end
  end

  # write the house data into database"
  #  /?roomId={New_ID}&
  #    roomName={NEW_NAME}&
  #    roomPrice={NEW_PRICE}&
  #    address={NEW_ADDRESS}&
  #    airbnb_link={NEW_link}&
  #    roomIng={NEW_IMG}&
  #    bed={NEW_BED}&
  #    roomRank={NEW_RANK}
  post "/#{API_VER}/house/?" do
    begin
      body_params = JSON.parse(request.body.read)
      new_roomId = body_params[:roomId]
      new_roomName = body_params[:roomName]
      new_roomPrice = body_params[:roomPrice]
      new_address = body_params[:address]
      new_airbnb_link = body_params[:airbnb_link]
      new_roomImg = body_params[:roomImg]
      new_bed = body_params[:bed]
      new_roomRank = body_params[:roomRank]

      House.create(
        roomId: new_roomId,
        roomName: new_roomName,
        roomPrice: new_roomPrice,
        address: new_address,
        airbnb_link: new_airbnb_link,
        roomImg: new_roomImg,
        bed:  new_bed,
        roomRank: new_roomRank
        )

      content_type 'application/json'
      {
        roomId: new_roomId,
        roomName: new_roomName,
        roomPrice: new_roomPrice,
        address: new_address,
        airbnb_link: new_airbnb_link,
        roomImg: new_roomImg,
        bed:  new_bed,
        roomRank: new_roomRank
      }.to_json

    rescue
      content_type 'text/plain'
      halt 500, "Cannot create house (roomId: #{new_roomId})"
    end
  end

  post "/#{API_VER}/addHouse/?" do
    result = CreateHouse.call(request.body.read)

    if result.success?
      HouseRepresenter.new(result.value).to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end

  get "/#{API_VER}/getHouses/:location/?" do
    result = GetHouses.call(params)

    if result.success?
      content_type 'application/json'
      result.value.to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end

  get "/#{API_VER}/house/:roomId/?" do
    result = GetHouseByRoomId.call(params)
    content_type 'application/json'
    result.value
  end


end
