# frozen_string_literal: true

# Loads data from Facebook group to database
class FindProjectInfo
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    puts "---api---"
    puts params
    projectinfo = Project.where(id: params[:projectId])
    projectinfo = projectinfo.map do |projectInfo|
      name = projectInfo.projectName if projectInfo.projectName
      start = projectInfo.dateStart if projectInfo.dateStart
      ends = projectInfo.dateEnd if projectInfo.dateEnd

      { id: projectInfo.id,  projectName: name, projectStart: start, projectEnd: ends}
    end
    if projectinfo.nil?
      Left(Error.new(:not_found, "No Information for"))
    else
      Right(projectinfo)
    end
  end
end