# frozen_string_literal: true

# Loads data from Facebook group to database
class FindProjectInfo
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    #keyword = params[:projectId].gsub(/\+/, ' ')
    projectinfo = Project.where(params).all
    projectinfo = projectinfo.map do |projectInfo|
      name = projectInfo.projectName if projectInfo.projectName
      { id: projectInfo.id,  projectName: name, projectStart: start, projectEnd: ends}
    end
    if projectinfo.nil?
      Left(Error.new(:not_found, "No Information for"))
    else
      Right(projectinfo)
    end
  end
end
