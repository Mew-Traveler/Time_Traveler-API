# frozen_string_literal: true

# Time_traveler web service
class TimeTravelerAPI < Sinatra::Base
  # create new project
  post "/#{API_VER}/day/create/?" do
    result = CreateNewDay.call(JSON.parse request.body.read)
  end

  # Update dailyplan
  post "/#{API_VER}/day/update/?" do
  	result = UpdateDailyPlan.call(request.body.read)
  end

  # Create a new row in the house table and update dailyplan
  post "/#{API_VER}/day/newroom/?" do
    result = CreateHouseAndUpdateDay.call(JSON.parse request.body.read)
  end

  get "/#{API_VER}/day/:userEmail/:project_id/:nthday?" do
    result = GetDailyplanAndHouse.call(params)

    content_type 'application/json'
    result.value
  end
end
