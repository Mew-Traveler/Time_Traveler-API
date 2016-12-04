# frozen_string_literal: true
require_relative 'rent'

# Represents overall group information for JSON API output
class RentsRepresenter < Roar::Decorator
  include Roar::JSON

  collection :results, extend: RentRepresenter, class: Rent
end
