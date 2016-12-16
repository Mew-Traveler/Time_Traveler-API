# frozen_string_literal: true

# Represents overall group information for JSON API output
class ProjectRepresenter < Roar::Decorator
  include Roar::JSON

    property :id
	property :userId
	property :projectName
	property :dateStart
	property :dateEnd
end