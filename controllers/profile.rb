# frozen_string_literal: true

class TimeTravelerAPI < Sinatra::Base
  # user login
  get "/#{API_VER}/me/:userEmail?" do
    result = LogIn.call(params)

    if result.success?
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
  end
end
