# frozen_string_literal: true

# Create new day
class CreateNewDay
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_request_json, lambda { |request_body|
    begin
      data = { project_id: request_body['project_id'],
               nthday: request_body['nthday'],
               date: request_body['date']
             }
      Right(data)
    rescue
      Left(Error.new(:bad_request, 'request data error'))
    end
  }

  register :create_day, lambda { |data|

    day = Dailyplan.create( 
                  project_id: data[:project_id],
                  roomId: nil,
                  nthday: data[:nthday],
                  date: data[:date],
                  timeStart: nil,
                  timeEnd: nil,
                  locateStart: nil,
                  locateEnd: nil,
                  timeRemain: nil
                )
    Right(day)
    
  }

  

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :create_day
    end.call(params)
  end
end

