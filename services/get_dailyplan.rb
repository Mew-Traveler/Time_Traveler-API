# frozen_string_literal: true

# Get dailyplan
class GetDailyplan
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :get_dailyplan_by_project_id
      step :formate_the_data
    end.call(params)
  end

  register :validate_request_json, lambda { |request_body|
    begin
      data = { userEmail: request_body['userEmail'],
               project_id: request_body['project_id'],
               nthday: request_body['nthday']
             }
      Right(data)
    rescue
      Left(Error.new(:bad_request, 'request data error'))
    end
  }

  register :get_dailyplan_by_project_id, lambda { |data|
    begin
      puts "DATA------"
      puts data
      dailyplan = Dailyplan.find( project_id: data[:project_id],
                                  nthday: data[:nthday] )
      Right(dailyplan)
    rescue
      Left(Error.new(:not_found, 'could not find the dailyplan'))
    end
  }

  register :formate_the_data, lambda { |data|
    result = {
      project_id: data.project_id,
      roomId: data.roomId,
      nthday: data.nthday,
      date: data.date,
      timeStart: data.timeStart,
      timeEnd: data.timeEnd,
      locateStart: data.locateStart,
      locateEnd: data.locateEnd,
      timeRemain: data.timeRemain
    }.to_json

    Right(result)
  }

end
