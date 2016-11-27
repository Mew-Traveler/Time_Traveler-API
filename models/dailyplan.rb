# frozen_string_literal: true

# Represents a Posting's stored information
class Dailyplan < Sequel::Model
	many_to_one :project
	one_to_many :targets
	one_to_one :rent
end
