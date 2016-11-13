# frozen_string_literal: true

# MovlogAPI web service
class TimeTravelerAPI < Sinatra::Base
  # find projectId of user
  get "/#{API_VER}/myprojects/:userId?" do
    userId = params[:userId]

    begin
      userInfo = Owner.find(owner:userId)
      print "owner: "+userId+"\n"

      content_type 'application/json'
      #projects = {
        userData= Owner.map do |userInfo|
          userData = { id: userInfo.id }
          userData[:project] = userInfo.project if userInfo.project
          userData[:owner] = userInfo.owner if userInfo.owner
          userData[:group] = userInfo.group if userInfo.group
          { userData: userData }
        end
      #}
      userData.to_json
    rescue
      content_type 'text/plain'
      halt 404, "Cannot find user (userId: #{userId}) data"
    end
  end
end
