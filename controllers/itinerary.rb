# frozen_string_literal: true

# MovlogAPI web service
class TimeTravelerAPI < Sinatra::Base
  # find project information by projectid
  get "/#{API_VER}/myproject/:projectId?" do
      projectid = params[:projectId]
      projectresult = FindProjectInfo.call(projectid)
      if projectresult.success?
        content_type 'application/json'
        projectresult.value.to_json
     else
       ErrorRepresenter.new(projectresult.value).to_status_response
   end
  end

  #input new userproject
  post "/#{API_VER}/myproject?" do
    body_params = JSON.parse request.body.read

    newproject = LoadData.call(body_params)
    if newproject.success?
      newprojct = Project.create(projectName: newproject[:projectName], userId: newproject[:userId], dateEnd: newproject[:dateEnd], dateStart: newproject[:dateStart])
      content_type 'application/json'
      newproject.value.to_json
     else
       ErrorRepresenter.new(newproject.value).to_status_response
     end
  #
  #   begin
  #     if Project.find(id:newprojectId)
  #       halt 422, "Project (projectId: #{newprojectId})already exists"
  #     end
  #   # rescue
  #   #   content_type 'text/plain'
  #   #   halt 404, "Cannot find Project (projectId: #{newprojectId}) data"
  #   end
  #
  #   begin
  #     newprojct = Project.create(projectName: newprojectName, userId: newprojectUserId, dateEnd: newprojectEnd, dateStart: newprojectStart)
  #
  #     content_type 'application/json'
  #     newprojct.to_json
  #   rescue
  #     content_type 'text/plain'
  #     halt 500, "Cannot create project (id: #{newprojectId})"
  #   end
  end
end
