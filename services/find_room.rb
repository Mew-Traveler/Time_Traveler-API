# frozen_string_literal: true

# Loads data from Facebook group to database
class FindRooms
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    room = House.find(roomId: params["roomId"])
    if room.nil?
      Left(Error.new(:not_found, "You have no projects"))
    else
      Right(room)
    end
  end
end
