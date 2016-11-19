# frozen_string_literal: true

# MovlogAPI web service
class TimeTravelerAPI < Sinatra::Base
  # find user and his/hers projects
  get "/#{API_VER}/me/:userEmail?" do
    userEmail = params[:userEmail]
    begin
      userInfo = User.find(userEmail:userEmail)
      userId = userInfo.id
      projectData= Project.map do |projectInfo|
        name = projectInfo.projectName if projectInfo.projectName
        { id: projectInfo.id,  projectName: name}
      end
      content_type 'application/json'
      projectData.to_json
    rescue
      content_type 'text/plain'
      halt 404, "Cannot find user (userId: #{userId}) data"
    end
  end
  # create new user
  post "/#{API_VER}/me/?" do
   begin
     body_params = JSON.parse request.body.read
     print body_params['userEmail']
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
