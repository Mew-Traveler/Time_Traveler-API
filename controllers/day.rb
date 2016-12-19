# frozen_string_literal: true

# Time_traveler web service
class TimeTravelerAPI < Sinatra::Base
  # create new project
  post "/#{API_VER}/day/create/?" do
    result = CreateNewDay.call(JSON.parse request.body.read)
  end
end
