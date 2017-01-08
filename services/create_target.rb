# frozen_string_literal: true

# Create new project
class CreateNewTarget

  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_request_json, lambda { |request_body|
    puts request_body

    puts request_body['type']
    puts request_body['rating']
    puts request_body['address']
    puts request_body['site_name']
    puts request_body['nthday']

    begin
      data = {
               type: request_body['type'],
               rating: request_body['rating'],
               address: request_body['address'],
               site_name: request_body['site_name'],
               nthday: request_body['nthday']
             }
      Right(data)
    rescue
      Left(Error.new(:bad_request, 'request data error'))
    end
  }


  register :create_target, lambda { |data|
    puts "create_target"
    begin
      puts "create_target"

    target = TargetModal.create(
      type: data[:type],
      rating: data[:rating],
      address: data[:address],
      site_name: data[:site_name],
      nthday: data[:nthday]
      )
    Right(target)
    rescue
      Left(Error.new(:bad_request, 'request data error'))
    end
  }
  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :create_target
    end.call(params)
  end

end
