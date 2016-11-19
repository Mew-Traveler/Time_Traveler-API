# frozen_string_literal: true

# MovlogAPI web service
class TimeTravelerAPI < Sinatra::Base
  # find project information by projectid
  get "/#{API_VER}/myproject/:projectId?" do
    projectId = params[:projectId]
    begin
      content_type 'application/json'
      projectData= Project.map do |projectInfo|
        name = projectInfo.projectName if projectInfo.projectName
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

  #input new userproject
  post "/#{API_VER}/myproject?" do
    body_params = JSON.parse request.body.read
    newprojectName = body_params['projectName']
    newprojectStart = body_params['dateStart']
    newprojectEnd = body_params['dateEnd']
    newprojectUserId = body_params['userId']
    newprojectId = body_params['projectId']

    begin
      print 'newprojectId'+newprojectId
      if Project.find(id:newprojectId)
        halt 422, "Project (projectId: #{newprojectId})already exists"
      end
    # rescue
    #   content_type 'text/plain'
    #   halt 404, "Cannot find Project (projectId: #{newprojectId}) data"
    end

    begin
      newprojct = Project.create(projectName: newprojectName, userId: newprojectId, dateEnd: newprojectEnd, dateStart: newprojectStart)

      content_type 'application/json'
      newprojct.to_json
    rescue
      content_type 'text/plain'
      halt 500, "Cannot create project (id: #{newprojectId})"
    end
  end
end