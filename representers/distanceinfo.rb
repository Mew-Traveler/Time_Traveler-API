# frozen_string_literal: true

# Represents overall group information for JSON API output
class DistanceRepresenter < Roar::Decorator
  include Roar::JSON

  property :distance
  property :duration
end