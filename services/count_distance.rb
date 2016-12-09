# frozen_string_literal: true

# Write house data to database
class CountDistance
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :show_distance_info
    end.call(params)
  end

  register :validate_request_json, lambda { |request_body|

    result = Google::TrafficInfo.find(
      origins: request_body[:origins], 
      destinations: request_body[:destinations], 
      mode: request_body[:mode])

    value = {
      anaDistance: result.trafficAnaly['distance']['value'],
      anaDuration: result.trafficAnaly['duration']['text']
    }.to_json

    if value
  	  Right(value)
  	else
  	  Left(Error.new(:bad_request, 'Wrong input data for counting distance'))
  	end
  }

  register :show_distance_info, lambda { |data|
    representation = FlightRepresenter.new(Dis.new)
    Right(representation.from_json(data))
  }
end
