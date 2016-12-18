# frozen_string_literal: true

# Represents overall group information for JSON API output
class AtraccioneRepresenter < Roar::Decorator
  include Roar::JSON

  property :address
  property :lat
  property :lng
  property :icon
  property :id
  property :placename
  property :opening_hours
  property :place_id
  property :rating
  property :types



end
