
# frozen_string_literal: true

# Represents a Posting's stored information
class Targets < Sequel::Model
  one_to_one :site_id
end