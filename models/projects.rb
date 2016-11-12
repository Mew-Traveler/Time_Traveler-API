
# frozen_string_literal: true

# Represents a Posting's stored information
class Projects < Sequel::Model
  one_to_one :traffic_id, :project_day, :bnb_id
end