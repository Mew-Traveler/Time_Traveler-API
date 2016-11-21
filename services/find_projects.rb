# frozen_string_literal: true

# Loads data from Facebook group to database
class FineProjects
  extend Dry::Monads::Either::Mixin

  def self.call(userId)
    #keyword = params[:userId].gsub(/\+/, ' ')
    projects = Project.where(userId: userId).all
    projects = projects.map do |projectInfo|
      name = projectInfo.projectName if projectInfo.projectName
      { id: projectInfo.id,  projectName: name}
    end
    if projects.nil?
      Left(Error.new(:not_found, "You have no projects"))
    else
      # print "\n"+projects
      Right(projects)
    end
  end
end
