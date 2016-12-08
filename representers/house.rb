# frozen_string_literal: true

# Represents the house data
class HouseRepresenter < Roar::Decorator
  include Roar::JSON

  property :id
  property :name
  property :price
  property :address
  property :airbnb_link
  property :roomImg
  property :bed
  property :roomRank
end
