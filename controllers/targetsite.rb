# frozen_string_literal: true

# MovlogAPI web service
class TimeTravelerAPI < Sinatra::Base
  # find user and his/hers projects
  get "/#{API_VER}/targetsite/:projectName?" do
    projectName = params[:projectName]
    begin
      project = Project.find(projectName: projectName)
      alltargets = project.targets

      targets = {
        targets: alltargets do |tar|
          target = {
            id: tar.id
            project_id: project.id  
          }
          target[:project_day] = tar.project_day if tar.project_day
          target[:idx] = tar.idx if tar.idx
          target[:type] = tar.type if tar.type
          target[:start_time] = tar.start_time if tar.start_time
          target[:end_time] = tar.end_time if tar.end_time
        end
      }

      content_type 'application/json'
      targets.to_json
    rescue
      content_type 'text/plain'
      halt 404, "There is no target for the #{projectName} yet"
    end
  end
end
