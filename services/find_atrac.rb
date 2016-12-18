# frozen_string_literal: true

# Loads data from Facebook group to database
class FindAtrac
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    puts "api-dailyplan.rb//findSite"
    puts params

    atracs = Google::GooglePlaceRating.find(query:params[:query])
    atracs = atracs.attracs.map do |atrac|
      AtraccioneRepresenter.new(Atraccione.new).from_json(atrac.to_json.to_s)
    end

    results = Atracciones.new(atracs)
    Right(results)
    # puts "api-dailyplan.rb//queries"

    # room = House.find(roomId: params["roomId"])
    # if atracs.nil?
    #   Left(Error.new(:not_found, "Google place find error"))
    # else
    #   puts "rating_rawdata"
    #   results = {
    #     results_atrac: atracs.attracs
    #   }
    #   # results = {
    #   #   results: atracs.rating_rawdata.map do |atrac|
    #   #     result = {
    #   #       id: atrac[:id],
    #   #       name: atrac[:name],
    #   #       address: atrac[:formatted_address],
    #   #       geometry: atrac[:geometry],
    #   #       icon: atrac[:icon],
    #   #       opening_hours: atrac[:opening_hours],
    #   #       photos: atrac[:photos],
    #   #       place_id: atrac[:place_id],
    #   #       rating: atrac[:rating],
    #   #       types: atrac[:types],
    #   #     }
    #   #   end
    #   # }
    #   Right(results)
    # end
  end
end
