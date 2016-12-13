# frozen_string_literal: true

# Loads data from Facebook group to database
class CreateUsers
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :checkUser, lambda { |params|
    user = User.find(userEmail: params)
    puts user
    if user
      Left(Error.new(:conflict, 'User exists'))
    else
      Right(params)
    end
  }

  register :createUser, lambda { |userEmail|
    newuser = User.create(userEmail: userEmail)
    Right(newuser)
  }


  def self.call(params)
    Dry.Transaction(container: self) do
      step :checkUser
      step :createUser
    end.call(params)
  end
end
