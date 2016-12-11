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
  	results = {
      results: data.infos.map do |room|
        result = {
          id: room[:id],
          name: room[:name],
          address: room[:address],
          airbnb_link: room[:airbnb_link],
          roomImg: room[:roomImg],
          bed: room[:bed],
          roomRank: room[:roomRank]
        }
      end
    }
    Right(results)
  }
end
