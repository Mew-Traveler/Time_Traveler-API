# frozen_string_literal: true

# Update dailyplan
class UpdateDailyPlan
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :update_the_dailyplan
    end.call(params)
  end

  register :validate_request_json, lambda { |request_body|
  	begin
  	  day_representation = DayRepresenter.new(Day.new)
  	  Right(day_representation.from_json(request_body))
  	rescue
  	  Left(Error.new(:bad_request, 'Wrong input dailyplan data'))
  	end
  }

  register :update_the_dailyplan, lambda { |data|
    begin

      day = Dailyplan.find(project_id: data[:project_id], 
                           nthday: data[:nthday])
      day.roomId = data[:roomId]
      day.nthday = data[:nthday]
      day.date = data[:date]
      day.timeStart = data[:timeStart]
      day.timeEnd = data[:timeEnd]
      day.locateStart = data[:locateStart]
      day.locateEnd = data[:locateEnd]
      day.timeRemain = data[:timeRemain]
      day.save

      Right(day)
    rescue 
      Left(Error.new(:bad_request, 'Cannot update the dailyplan in DB'))
    end

  }

end
