# frozen_string_literal: true

# TimeTravelerAPI web service
class TimeTravelerAPI < Sinatra::Base
  # get the data from airbnb api with the location
  get "/#{API_VER}/rent/:location/?" do
    location = params[:location]
    result = FindLocRent.call(location)
    if result.success?
       content_type 'application/json'
       result.value.to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end

  # get the house data from database
  get "/#{API_VER}/house/:roomId/?" do
    result = FindRooms.call(params)
    if result.success?
       content_type 'application/json'
       result.value.to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end
  #create a new house data
  post "/#{API_VER}/house/?" do
    data = JSON.parse request.body.read
    result = CreateRooms.call(data)
    if result.success?
      result.value.to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end
end
