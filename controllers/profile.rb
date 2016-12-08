# frozen_string_literal: true

class TimeTravelerAPI < Sinatra::Base
  # find user and his/hers projects
  get "/#{API_VER}/me/:userEmail?" do
      userId_result = FindUserId.call(params)
      if userId_result.success?
        projectData = FindProjects.call(params)
        if projectData.success?
         content_type 'application/json'
         projectData.value.to_json
        else
          ErrorRepresenter.new(projectData.value).to_status_response
        end
      else
        ErrorRepresenter.new(userId_result.value).to_status_response
      end
  end
  # create new user
  post "/#{API_VER}/me/?" do
    userData = JSON.parse request.body.read
    userEmail = userData['userEmail']
     userId_result = CreateUsers.call(userEmail)
    if userId_result.success?
      userId_result.value.to_json
    else
      ErrorRepresenter.new(userId_result.value).to_status_response
    end
   end
end
