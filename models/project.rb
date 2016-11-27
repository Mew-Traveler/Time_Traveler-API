# frozen_string_literal: true

# Represents a Posting's stored information
class Project < Sequel::Model
	one_to_many :dailyplans
end