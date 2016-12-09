# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerAPI < Sinatra::Base
  # find project information by projectid
  get "/#{API_VER}/myproject/:projectId?" do
        # projectId = params[:projectId]
    results = FindProjectInfo.call(params)

    if results.success?
      content_type 'application/json'
      results.value.to_json
    else
      ErrorRepresenter.new(results.value).to_status_response
    end
  end

  #input new userproject
  post "/#{API_VER}/myproject?" do
    projectData = JSON.parse request.body.read
     result = CreateProjects.call(projectData)
    if result.success?
      result.value.to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end

  #input new daily settings
  post "/#{API_VER}/myproject/dailyplan" do
    dailyData = JSON.parse request.body.read
     result = CreateDailys.call(dailyData)
    if result.success?
      result.value.to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end
  #get dailyplan data
  get "/#{API_VER}/myproject/dailyplan/:projectId/:day?" do
    result = CreateDailys.call(params)
    if result.success?
      content_type 'application/json'
      result.value.to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end
end
