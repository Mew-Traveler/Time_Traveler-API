# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerAPI < Sinatra::Base
  # find project information by projectid
  get "/#{API_VER}/myproject/:projectId?" do
    projectId = params[:projectId]
    begin
      content_type 'application/json'
      # dailyplandata= Dailyplan.where(projectId:projectId, day:day)
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
    newprojectGroupId = body_params['groupId']

    # begin
    #   if Project.find(id:newprojectId)
    #     halt 422, "Project (projectId: #{newprojectId})already exists"
    #   end
    # # rescue
    # #   content_type 'text/plain'
    # #   halt 404, "Cannot find Project (projectId: #{newprojectId}) data"
    # end

    begin
      newprojct = Project.create(projectName: newprojectName, userId: newprojectId, dateEnd: newprojectEnd, dateStart: newprojectStart)

      content_type 'application/json'
      newprojct.to_json
    rescue
      content_type 'text/plain'
      halt 500, "Cannot create project (id: #{newprojectId})"
    end
  end

  #input new daily settings
  post "/#{API_VER}/myproject/dailyplan" do
    body_params = JSON.parse request.body.read
    newdailyprojectId = body_params['projectId']
    newdailyroomId = body_params['roomId']
    newdailynthday = body_params['nthday']
    newdailytimeStart = body_params['timeStart']
    newdailytimeEnd = body_params['timeEnd']
    newdailylocateStart = body_params['locateStart']
    newdailylocateEnd = body_params['locateEnd']
    newdailytimeRemain = body_params['timeRemain']

    # begin
    #   if Dailyplan.find(project_id: newdailyprojectId)
    #     halt 422, "plan (dailyplan: #{newdailyprojectId})already exists"
    #   end
    # rescue
    #   content_type 'text/plain'
    #   halt 404, "Cannot find Project (projectId: #{newprojectId}) data"
    # end
    begin
      newDaily = Dailyplan.create(project_id: newdailyprojectId, roomId: newdailyroomId,
       nthday: newdailynthday, timeStart: newdailytimeStart, timeEnd: newdailytimeEnd,
      locateStart: newdailylocateStart, locateEnd: newdailylocateEnd, timeRemain: newdailytimeRemain)

      content_type 'application/json'
      newDaily.to_json
    rescue
      content_type 'text/plain'
      halt 500, "Cannot create project (id: #{newdailyprojectId})"
    end
  end
  #get dailyplan data
  get "/#{API_VER}/myproject/dailyplan/:projectId/:day?" do
    projectId = params[:projectId]
    day = params[:day]
    begin
      content_type 'application/json'
      dailyplandata= Dailyplan.find(project_id:projectId, nthday:day)
        timeRemain = dailyplandata.timeRemain if dailyplandata.timeRemain
        locateEnd = dailyplandata.locateEnd if dailyplandata.locateEnd
        locateStart = dailyplandata.locateStart if dailyplandata.locateStart
        timeEnd = dailyplandata.timeEnd if dailyplandata.timeEnd
        timeStart = dailyplandata.timeStart if dailyplandata.timeStart
        date = dailyplandata.date if dailyplandata.date
        dailyplandata.to_json
    rescue
      content_type 'text/plain'
      halt 404, "Cannot find user (userId: #{userId}) data"
    end
  end
end
