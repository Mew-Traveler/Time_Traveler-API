# frozen_string_literal: true

# Represents the dailyplan data
class DayRepresenter < Roar::Decorator
  include Roar::JSON

  property :project_id
  property :roomId
  property :nthday
  property :date
  property :timeStart
  property :timeEnd
  property :locateStart
  property :locateEnd
  property :timeRemain
end
