# frozen_string_literal: true

# Loads data from Facebook group to database
class CreateDailys
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :checkDaily, lambda { |params|
    print params
    daily = Dailyplan.find(projectId: params['projectId'], nthday: params['nthday'])
    if daily
      Left(Error.new(:conflict, 'Daily exists'))
    else
      Right(params)
    end
  }
  register :createDaily, lambda { |params|
    newdaily = Dailyplan.create(projectId: params['projectId'], roomId: params['roomId'], nthday: params['nthday'],
     timeStart: params['timeStart'], timeEnd: params['timeEnd'], locateStart: params['locateStart'], locateEnd: params['locateEnd'],
     timeRemain: params['timeRemain'])
    Right(newdaily)
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :checkDaily
      step :createDaily
    end.call(params)
  end
end
