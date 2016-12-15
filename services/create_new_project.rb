# frozen_string_literal: true

# Create new project
class CreateNewProject
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_request_json, lambda { |request_body|
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

    project = Project.create( userId: data[:userId],
                    projectName: data[:projectName],
                    dateStart: data[:dateStart],
                    dateEnd: data[:dateEnd],
                    groupId: nil )
    Right(project)
    
  }

  

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :get_user_id
      step :create_project
    end.call(params)
  end
end

