# frozen_string_literal: true
require_relative 'house'

# Represents overall page information for JSON API output
class HousesRepresenter < Roar::Decorator
  include Roar::JSON

  collection :houses, extend: HouseRepresenter, class: House
end
