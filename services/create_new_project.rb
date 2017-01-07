# frozen_string_literal: true

# Create new project
class CreateNewProject
  require 'date'

  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_request_json, lambda { |request_body|
    puts request_body['userEmail']
    puts request_body['projectName']
    puts request_body['dateStart']
    puts request_body['dateEnd']
    begin
      data = { userEmail: request_body['userEmail'],
               projectName: request_body['projectName'],
               dateStart: request_body['dateStart'],
               dateEnd: request_body['dateEnd']
             }
      Right(data)
    rescue
      Left(Error.new(:bad_request, 'request data error'))
    end
  }

  register :get_user_id, lambda { |data|
    begin
      user = User.find(userEmail: data[:userEmail])
      data[:userId] = user.id
      Right(data)
    rescue
      Left(Error.new(:not_found, 'could not find the user id by userEmail'))
    end
  }

  register :create_project, lambda { |data|

    project = Project.create(
      userId: data[:userId],
      projectName: data[:projectName],
      dateStart: data[:dateStart],
      dateEnd: data[:dateEnd],
      groupId: nil
      )
    Right(project)

  }

  register :create_days_by_project, lambda { |project|

    info = {
      project_id: project.id,
      dateStart: project.dateStart,
      dateEnd: project.dateEnd
    }

    CreateDaysByProject.call(JSON.parse info.to_json)
    day = (Date.parse(project.dateEnd)- Date.parse(project.dateStart)).to_i
    result = {
      projects: [{
        id: project.id,
        userId: project.userId,
        projectName: project.projectName,
        dateStart: project.dateStart,
        dateEnd: project.dateEnd,
        day: day
        #day: cal_days(project.dateStart, project.dateEnd)
      }]
    }.to_json

    Right(result)

  }



  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :get_user_id
      step :create_project
      step :create_days_by_project
    end.call(params)
  end

  private_class_method

  def self.cal_days(date1, date2)
    m1 = date1.split('/')[0].to_i
    d1 = date1.split('/')[1].to_i
    m2 = date2.split('/')[0].to_i
    d2 = date2.split('/')[1].to_i

    if (m2 == m1)
      result = d2 - d1 + 1
    else
      result = (30 - d1 + 1) + d2 + (m2 - m1 - 1) * 30
    end

    return result
  end
end
