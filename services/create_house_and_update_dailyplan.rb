# frozen_string_literal: true

# Create new house and update the dailyplan if push the choose button
class CreateHouseAndUpdateDay
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_request_json, lambda { |request_body|
    begin
      data = { dailyplanInfo: request_body['dailyplanInfo'],
               roomInfo: request_body['roomInfo']
             }
      Right(data)
    rescue
      Left(Error.new(:bad_request, 'request data error'))
    end
  }

  register :create_house, lambda { |data|
    begin
      house_data = data[:roomInfo].to_json
      house = CreateHouse.call(house_data)
      data[:house_id] = house.value.roomId

      Right(data)
    rescue
      Left(Error.new(:bad_request, 'house request data error'))
    end
  }

  register :update_dailyplan, lambda { |data|
    day_info = { "project_id": data[:dailyplanInfo]['project_id'],
                 "nthday": data[:dailyplanInfo]['nthday'],
                 "roomId": data[:house_id],
                 "date": data[:dailyplanInfo]['date'],
                 "timeStart": data[:dailyplanInfo]['timeStart'],
                 "timeEnd": data[:dailyplanInfo]['timeEnd'],
                 "locateStart": data[:dailyplanInfo]['locateStart'],
                 "locateEnd": data[:dailyplanInfo]['locateEnd'],
                 "timeRemain": data[:dailyplanInfo]['timeRemain'] }.to_json
    UpdateDailyPlan.call(day_info)

    Right(day_info)
  }

  

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :create_house
      step :update_dailyplan
    end.call(params)
  end
end

