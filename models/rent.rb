# frozen_string_literal: true

# Represents a Posting's stored information
class Rent < Sequel::Model
	one_to_one :dailyplan
end