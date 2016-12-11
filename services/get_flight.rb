# frozen_string_literal: true

# Write house data to database
class GetFlight
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :delete_empty
      step :extract_flight
      # step :show_flight_info
    end.call(params)
  end

  register :validate_request_json, lambda { |request_body|
    result = Skyscanner::FlightInfo.find(market: request_body[:market], currency: request_body[:currency], locale: request_body[:locale], 
      originPlace: request_body[:originPlace], destinationPlace: request_body[:destinationPlace], 
      outboundPartialDate: request_body[:outboundPartialDate])

    if result
  	  Right(result)
  	else
  	  Left(Error.new(:bad_request, 'Wrong input data for counting distance'))
  	end
  }

  register :delete_empty, lambda { |result|
    infos = result.flightInfo
    infos.map do |info|
      if info["OutboundLeg"]["CarrierIds"].empty?
        infos.delete(info)
      end
    end
    Right(infos)
  }
  
  # problem, the reference will cause the repeated results
  register :extract_flight, lambda { |infos|
    flight = Array.new(infos.length)
    flight_collection = []
    i = 0
    flights = {
      flights: infos.map do |info|
        representation = FlightRepresenter.new(Flight.new)
        flight[i] = Hash.new
        flight[i][:carrier] = info["OutboundLeg"]["CarrierIds"][0] if info["OutboundLeg"]["CarrierIds"][0]
        flight[i][:originPlace] = info["OutboundLeg"]["OriginId"] if info["OutboundLeg"]["OriginId"]
        flight[i][:destinationPlace] = info["OutboundLeg"]["DestinationId"] if info["OutboundLeg"]["DestinationId"]
        flight_collection.push(representation.from_json(flight[i].to_json))
        i+=1
      end
    }
    flights.each do |flight|
      puts flight
    end
    Right(flight_collection)
  }
end
