require 'roar/decorator'
require 'roar/json'

# Uaage : p1 = Project.new(5, 1, 'Hello', 'wtlin1228')
#         project_in_json = ProjectRepresenter.new(p1).to_json

class ProjectRepresenter < Roar::Decorator
	include Roar::JSON

	property :userId
    property :projectName
    property :dateStart
    property :dateEnd

end


# class Project
# 	attr_reader :userId, :projectName, :dateStart, :dateEnd

# 	def initialize(userId, projectName, dateStart, dateEnd)
# 		@userId = userId
# 		@projectName = projectName
# 		@dateStart = dateStart
# 		@dateEnd = dateEnd
# 	end
# end