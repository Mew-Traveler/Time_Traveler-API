# frozen_string_literal: true

# MovlogAPI web service
class TimeTravelerAPI < Sinatra::Base
  # find user and his/hers projects
  get "/#{API_VER}/me/:userEmail?" do
      userId_result = FindUserId.call(params)
      if userId_result.success?
        projectData = FindProjects.call(userId_result.value)
        if projectData.success?
         content_type 'application/json'
         projectData.value.to_json
        else
          ErrorRepresenter.new(projectData.value).to_status_response
        end
      else
        print userId_result.value
        ErrorRepresenter.new(userId_result.value).to_status_response
      end
  end
  # create new user
  post "/#{API_VER}/me/?" do
   begin
     body_params = JSON.parse request.body.read

     newuserEmail = body_params['userEmail']

     if User.find(userEmail: newuserEmail)
       halt 422, "User (userEmail: #{userEmail})already exists"
     end

   rescue
     content_type 'text/plain'
     halt 422, "User (userEmail: #{newuserEmail})already exists"
   end

   begin
     newuser = User.create(userEmail: newuserEmail)

     content_type 'application/json'
     { userEmail: newuserEmail}.to_json
   rescue
     content_type 'text/plain'
     halt 500, "Cannot create user (id: #{newuserEmail})"
   end
  end
end
