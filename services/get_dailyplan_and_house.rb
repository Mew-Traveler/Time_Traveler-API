# frozen_string_literal: true

# Get house by room id
class GetDailyplanAndHouse
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :get_dailyplan
      step :get_house
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

  register :get_dailyplan, lambda { |data|
    begin
      dailyplan_info = GetDailyplan.call(JSON.parse data.to_json)
      Right(dailyplan_info)
    rescue
      Left(Error.new(:not_found, 'could not find the dailyplan'))
    end
  }

  register :get_house, lambda { |data|
    begin
      d = JSON.parse data.value
      house = GetHouseByRoomId.call(d)
      house_info = JSON.parse house.value

      result = {
        dailyplan_info: d,
        house_info: house_info
      }

      Right(result)
    rescue
      Left(Error.new(:not_found, 'could not find the dailyplan'))
    end
  }

  register :formate_the_data, lambda { |data|
    Right(data.to_json)
  }

end

