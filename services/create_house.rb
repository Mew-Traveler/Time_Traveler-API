# frozen_string_literal: true

# Write house data to database
class CreateHouse
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :write_to_house_table
    end.call(params)
  end

  register :validate_request_json, lambda { |request_body|
    puts "here is request body"
    puts request_body
  	begin
  	  house_representation = HouseRepresenter.new(Room.new)
  	  Right(house_representation.from_json(request_body))
  	rescue
      puts "wrong input house data"
  	  Left(Error.new(:bad_request, 'Wrong input house data'))
  	end
  }

  register :write_to_house_table, lambda { |data|
    puts "update house now..."
    puts data[:id]
    puts data[:name]
    puts data[:price]
    puts data[:address]
  	room = House.create(
             roomId: data[:id],
             roomName: data[:name],
             roomPrice: data[:price],
             address: data[:address],
             airbnb_link: data[:airbnb_link],
             roomImg: data[:roomImg],
             bed:  data[:bed],
             roomRank: data[:roomRank]
           )
  
    Right(room)
  }
end
