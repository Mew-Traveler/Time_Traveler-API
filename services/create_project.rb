# frozen_string_literal: true

# Loads data from Facebook group to database
class CreateProjects
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :checkProject, lambda { |params|
    project = Project.find(userEmail: params['userEmail'], projectName: params['projectName'])
    if project
      Left(Error.new(:conflict, 'Project exists'))
    else
      Right(params)
    end
  }
#      newprojct = Project.create(projectName: newprojectName, userId: newprojectUserId, dateEnd: newprojectEnd, dateStart: newprojectStart)

  register :createProject, lambda { |params|
    newprojct = Project.create(projectName: params['projectName'], userEmail: params['userEmail'], dateEnd: params['dateEnd'],
     dateStart: params['dateStart'])
    Right(newprojct)
  }


  def self.call(params)
    Dry.Transaction(container: self) do
      step :checkProject
      step :createProject
    end.call(params)
  end
end
