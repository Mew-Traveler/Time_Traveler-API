# frozen_string_literal: true

# Represents overall listing information for JSON API output
class PostingRepresenter < Roar::Decorator
  include Roar::JSON

  property :airbnb_plus_enabled
  property :bathrooms
  property :bedrooms
  property :beds
  property :city
  property :coworker_hosted
  property :distance
  property :extra_host_languages
  property :id
  property :instant_bookable
  property :is_business_travel_ready
  property :is_new_listing
  property :lat
  property :listing_tags
  property :lng
  property :name
  property :neighborhood
  property :person_capacity
  property :picture_count
  property :picture_url
  property :primary_host
  property :property_type
  property :property_type_id
  property :public_address
  property :reviews_count
  property :room_type
  property :room_type_category
  property :scrim_color
  property :star_rating
  property :thumbnail_url
  property :user_id
  property :xl_picture_url
  property :preview_encoded_png
  property :picture_urls
  property :user
  property :xl_picture_urls
  
end

