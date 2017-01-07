# frozen_string_literal: true

# Represents a Posting's stored information
class TargetModal < Sequel::Model
	many_to_one :dailyplans
	many_to_one :projects
end
