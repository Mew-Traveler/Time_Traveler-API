# frozen_string_literal: true
require_relative 'listing'

# Represents overall group information for JSON API output
class ListingsRepresenter < Roar::Decorator
  include Roar::JSON

  # collection :listings, extend: ListingRepresenter, class: Listing
end
