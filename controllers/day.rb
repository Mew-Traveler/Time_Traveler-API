# frozen_string_literal: true

# Time_traveler web service
class TimeTravelerAPI < Sinatra::Base
  # create new project
  post "/#{API_VER}/day/create/?" do
    result = CreateNewDay.call(JSON.parse request.body.read)

    # if result.success?
    #   PageRepresenter.new(result.value).to_json
    # else
    #   ErrorRepresenter.new(result.value).to_status_response
    # end
  end
end
