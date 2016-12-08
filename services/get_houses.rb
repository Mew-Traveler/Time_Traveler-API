# frozen_string_literal: true

# Get houses data from database
class GetHouses
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :call_api_to_get_houses
      step :format_the_house_data
    end.call(params)
  end

  register :call_api_to_get_houses, lambda { |request_body|
  	begin
  	  houses = Airbnb::RentInfo.find(location: request_body[:location])      
      Right(houses)
  	rescue
  	  Left(Error.new(:bad_request, 'Cannot get the house data form airbnb'))
  	end
  }

  register :format_the_house_data, lambda { |data|
  	house_representation = HouseRepresenter.new(Room.new)
    room_collection = []
    data.infos.each do |room|
      room_collection.push(house_representation.from_json(room.to_json))
    end  

  }
end
