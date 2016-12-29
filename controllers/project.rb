# frozen_string_literal: true

# Time_traveler web service
class TimeTravelerAPI < Sinatra::Base
  # create new project
  post "/#{API_VER}/project/create/?" do
    
    result = CreateNewProject.call(JSON.parse request.body.read)

    content_type 'application/json'
    result.value
    # if result.success?
    #   PageRepresenter.new(result.value).to_json
    # else
    #   ErrorRepresenter.new(result.value).to_status_response
    # end
  end

  # get project information
  get "/#{API_VER}/project/:userEmail/:project_id/:nthday?" do
  	result = GetDailyplanAndHouse.call(params)

  	content_type 'application/json'
    result.value
  end
end
