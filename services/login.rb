class LogIn
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
  	@userEmail = params[:userEmail]
    Dry.Transaction(container: self) do
    	step :check_email_exist
    	step :get_all_projects
    end.call(params)
  end


  register :check_email_exist, lambda { |params|
    if (userInfo = User.find(userEmail: params[:userEmail])).nil?
      Left(Error.new(:not_found, '#{params[:userEmail]} not found'))
    else
      Right(userInfo)
    end
  }

  register :get_all_projects, lambda { |input|
  	puts @userEmail
    userInfo = User.find(userEmail: @userEmail)
    userId = userInfo.id.to_s
    #why can't not just use Project.find?
    # ps = Project.find(userId: userId)
    # puts ps.length
    projects_collection = []
  	projects = {
      projects: Project.map do |project|
      	if project[:userId] == userId
         #  puts "YOOOOOOOOOOOO"
         #  puts project[:id]
      	  # representation = ProjectRepresenter.new(Project.new)
          project = {
            id: project[:id].to_s,
            userId: project[:userId],
            projectName: project[:projectName],
            dateStart: project[:dateStart],
            dateEnd: project[:dateEnd]
          }
         #  projects_collection.push(representation.from_json(project.to_json))
        end
      end
    }
    # wtlin0711@gmail.com
    # content_type 'application/json'
    Right(projects)	
  }
end