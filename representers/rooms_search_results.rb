# frozen_string_literal: true
require_relative 'listing'

# Represents overall group information for JSON API output
class RoomsSearchResultsRepresenter < Roar::Decorator
  include Roar::JSON

  property :search_terms_used
  #collection :listings, extend: ListingsRepresenter, class: Listing
end
