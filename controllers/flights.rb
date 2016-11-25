# frozen_string_literal: true

# Time_Traveler-API web service
class TimeTravelerAPI < sinatra::Base
  get "/#{API_VER}/flight/:market/:currency/:locale/:originPlace/:destinationPlace/:outboundPartialDate?" do
    market = params[:market]
    currency = params[:currency]
    locale = params[:locale]
    originPlace = params[:originPlace]
    destinationPlace = params[:destinationPlace]
    outboundPartialDate = params[:outboundPartialDate]
    begin
      flight = Skyscanner::FlightInfo.find(market: market, currency: currency, locale: locale, originPlace: originPlace, destinationPlace: destinationPlace, outboundPartialDate: outboundPartialDate)
      content_type 'application/json'
      {
        flightsInfo: flight.flightInfo
      }.to_json
    rescue
      halt 404, "Cannot return flight data"
    end
  end

  post "/#{API_VER}/flight/?" do
    begin

      flightInfo = Skyscanner::FlightInfo.find(market: 'TW', currency: 'TWD', locale: 'en-GB', originPlace: 'TW', destinationPlace: 'UK', outboundPartialDate: '2016-11-20')
    rescue
      content_type 'text/plain'
      halt 400, "Group (url: #{skyscanner_url}) could not be found"
    end

    begin
    rescue
    end
  end
end
