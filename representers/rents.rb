# frozen_string_literal: true
require_relative 'rent'

# Represents overall group information for JSON API output
class RentsRepresenter < Roar::Decorator
  include Roar::JSON

  collection :rents, extend: RentRepresenter, class: Rent
end
