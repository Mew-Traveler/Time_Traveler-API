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
    puts userId
    #why can't not just use Project.find?
    ps = Project.where(Sequel.like(:userId, userId))
    temp = ps.all
  	projects = {
      projects: temp.map do |ele|
       	# if project[:userId] == userId
          project = {
            id: ele[:id].to_s,
            userId: ele[:userId],
            projectName: ele[:projectName],
            dateStart: ele[:dateStart],
            dateEnd: ele[:dateEnd]
          }
        # end
      end
    }

    # wtlin0711@gmail.com
    # content_type 'application/json'
    Right(projects)	
  }
end