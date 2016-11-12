
# frozen_string_literal: true

# Represents a Posting's stored information
class Owners < Sequel::Model
  one_to_many :project, :group
end