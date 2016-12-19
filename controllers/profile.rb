# frozen_string_literal: true

# MovlogAPI web service
class TimeTravelerAPI < Sinatra::Base
  
  get "/#{API_VER}/me/:userEmail?" do

    result = LogIn.call(params)

    if result.success?
      puts result.value
      content_type 'application/json'
      result.value.to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
  end

  # create new user
  post "/#{API_VER}/createUser/?" do
    body_params = JSON.parse request.body.read

    result = CreateNewUser.call(body_params)

    if result.success?
      content_type 'application/json'
      result.value.to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end

   # begin
   #   body_params = JSON.parse request.body.read
   #   print body_params['userEmail']
   #   newuserEmail = body_params['userEmail']

   #   if User.find(userEmail: newuserEmail)
   #     halt 422, "User (userEmail: #{userEmail})already exists"
   #   end

   # rescue
   #   content_type 'text/plain'
   #   halt 422, "User (userEmail: #{newuserEmail})already exists"
   # end

   # begin
   #   newuser = User.create(userEmail: newuserEmail)

   #   content_type 'application/json'
   #   { userEmail: newuserEmail}.to_json
   # rescue
   #   content_type 'text/plain'
   #   halt 500, "Cannot create user (id: #{newuserEmail})"
   # end
  end
end
