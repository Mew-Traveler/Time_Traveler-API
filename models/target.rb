# frozen_string_literal: true

# Represents a Posting's stored information
class Target < Sequel::Model
	many_to_one :project
end