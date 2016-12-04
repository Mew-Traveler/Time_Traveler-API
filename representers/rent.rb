# frozen_string_literal: true

# Represents overall group information for JSON API output
class RentRepresenter < Roar::Decorator
  include Roar::JSON

  property :id
  property :name
  property :address
  property :airbnb_link
  property :roomImg
  property :bed
  property :roomRank


end
