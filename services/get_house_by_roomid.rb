# frozen_string_literal: true

# Get house by room id
class GetHouseByRoomId
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :gethouse_by_roomid
      step :formate_the_data
    end.call(params)
  end

  register :validate_request_json, lambda { |request_body|
    begin
      data = { roomId: request_body['roomId'] }
      Right(data)
    rescue
      Left(Error.new(:bad_request, 'request data error'))
    end
  }

  register :gethouse_by_roomid, lambda { |data|
    begin
      house = House.find( roomId: data[:roomId] )
      Right(house)
    rescue
      Left(Error.new(:not_found, 'could not find the house'))
    end
  }

  register :formate_the_data, lambda { |data|
    begin
      result = {
        roomId: data.roomId,
        roomName: data.roomName,
        roomPrice: data.roomPrice,
        address: data.address,
        airbnb_link: data.airbnb_link,
        roomImg: data.roomImg,
        bed: data.bed,
        roomRank: data.roomRank
      }.to_json
  
      Right(result)
    rescue
      Left(Error.new(:not_found, 'could not find the house'))
    end
  }

end
