# frozen_string_literal: true

# Loads data from Facebook group to database
class CreateTargets
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin
  register :checkDaily, lambda { |params|
    daily = Dailyplan.find(id: params['dailyplan_id'])
    if daily
      Right(params)
    else
      Left(Error.new(:not_found, 'No DailyPlan' ))
    end
  }
  register :checkTarget, lambda { |params|
    target = Target.find(dailyplans_id: params['dailyplan_id'])
    if target
      Left(Error.new(:conflict, 'Target exists'))
    else
      Right(params)
    end
  }
#      newprojct = Project.create(projectName: newprojectName, userId: newprojectUserId, dateEnd: newprojectEnd, dateStart: newprojectStart)
  register :createTarget, lambda { |params|
    newSite = Target.create(dailyplans_id: params['dailyplan_id'], project_day: params['project_day'],
    idx: params['idx'], type: params['type'], start_time: params['start_time'],
     end_time: params['end_time'])
    Right(newSite)
  }


  def self.call(params)
    Dry.Transaction(container: self) do
      step :checkDaily
      step :checkTarget
      step :createTarget
    end.call(params)
  end
end
