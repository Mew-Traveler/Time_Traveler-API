# frozen_string_literal: true

# Loads data from Facebook group to database
class FindProjects
  extend Dry::Monads::Either::Mixin

  def self.call(userId)
    #keyword = params[:userId].gsub(/\+/, ' ')
    projects = Project.where(userEmail: userId).all
    projects = projects.map do |projectInfo|
      name = projectInfo.projectName if projectInfo.projectName
      print name
      { id: projectInfo.id,  projectName: name}
    end
    if projects.nil?
      Left(Error.new(:not_found, "You have no projects"))
    else
      Right(projects)
    end
  end
end
