# frozen_string_literal: true

# Loads data from Facebook group to database
class FindLocRent
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    rent = Airbnb::RentInfo.find(location: params)
    if rent.nil?
      Left(Error.new(:not_found, "Airbnb find error"))
    else
      results = {
        results: rent.infos.map do |room|
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
    end
  end
end
