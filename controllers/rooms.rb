# frozen_string_literal: true

# TimeTravelerAPI web service
class TimeTravelerAPI < Sinatra::Base

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
