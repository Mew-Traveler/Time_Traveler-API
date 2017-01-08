# frozen_string_literal: true

# Get dailyplan
class GetProjectInfo
  require 'date'
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :get_projectInfo_by_project_id
    end.call(params)
  end

  register :validate_request_json, lambda { |request_body|
    begin
      data = { project_id: request_body['project_id']
             }
      Right(data)
    rescue
      Left(Error.new(:bad_request, 'request data error'))
    end
  }

  register :get_projectInfo_by_project_id, lambda { |data|
    begin
      project = Project.find(id: data[:project_id])

      totalDays = (Date.parse(project.dateEnd)- Date.parse(project.dateStart)).to_i
      days = {
        totalDays:totalDays
      }
      Right(days.to_json)
    rescue
      Left(Error.new(:not_found, 'could not find the dailyplan'))
    end
  }
end
