# frozen_string_literal: true

# Loads data from Facebook group to database
class CreateRooms
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :checkRoom, lambda { |params|
    print params
    room = House.find(roomId: params['roomId'])
    if room
      Left(Error.new(:conflict, 'Room exists'))
    else
      Right(params)
    end
  }
  register :createRoom, lambda { |params|
    newroom = House.create(
      roomId: Dailyplan.first.roomId,
      roomName: params["roomName"],
      roomPrice: params["roomPrice"],
      address: params["address"],
      airbnb_link: params["airbnb_link"],
      roomImg: params["roomImg"],
      bed: params["bed"],
      roomRank: params["roomRank"]
      )
    Right(newroom)
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :checkRoom
      step :createRoom
    end.call(params)
  end
end
