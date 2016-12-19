# frozen_string_literal: true

# Create new project
class CreateNewUser
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_request_json, lambda { |request_body|
    puts request_body['userEmail']
    begin
      data = { userEmail: request_body['userEmail'] }
      Right(data)
    rescue
      Left(Error.new(:bad_request, 'request data error'))
    end
  }

  register :check_if_exist, lambda { |data|
    if User.find(userEmail: data[:userEmail])
      Left(Error.new(:bad_request, 'The account has been used.'))
    else
      Right(data)
    end
  }

  register :create_new_user, lambda { |data|

    newUser = User.create(userEmail: data[:userEmail])
    Right(newUser)   
  }


  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :check_if_exist
      step :create_new_user
    end.call(params)
  end
end

