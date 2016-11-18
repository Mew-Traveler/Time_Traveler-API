# frozen_string_literal: true

# MovlogAPI web service
class TimeTravelerAPI < Sinatra::Base
  # find projectId of user
  get "/#{API_VER}/myprojects/:userEmail?" do
    userEmail = params[:userEmail]
    begin

      userInfo = User.find(userEmail:userEmail)
      userId = userInfo.id

      content_type 'application/json'
      projectData= Project.map do |projectInfo|
        name = projectInfo.projectName if projectInfo.projectName
      #  owner = projectInfo.userEmail if projectInfo.userEmail
        start = projectInfo.dateStart if projectInfo.dateStart
        ends = projectInfo.dateEnd if projectInfo.dateEnd
        { id: projectInfo.id,  projectName: name, projectStart: start, projectEnd: ends}
      end

       projectData.to_json
    rescue
      content_type 'text/plain'
      halt 404, "Cannot find user (userId: #{userId}) data"
    end
  end

  post "/#{API_VER}/myprojects/?" do
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
