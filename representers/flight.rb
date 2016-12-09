# frozen_string_literal: true

# Represents the house data
class FlightRepresenter < Roar::Decorator
  include Roar::JSON

  property :carrier
  property :originPlace
  property :destinationPlace
end
