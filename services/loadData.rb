# frozen_string_literal: true

# Loads data from Facebook group to database
class LoadData
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    newprojectName = params['projectName']
    newprojectStart = params['dateStart']
    newprojectEnd = params['dateEnd']
    newprojectUserId = params['userId']
    newprojectId = params['projectId']
    newproject = {projectName: newprojectName, userId: newprojectUserId, dateEnd: newprojectEnd, dateStart: newprojectStart}
    if Project.find(id:newprojectId)
      Left(Error.new(:conflict, "Project already exists"))
    else
      Right(newproject)
    end
  end
end
