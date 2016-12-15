# frozen_string_literal: true

# TimeTravelerAPI web service
class TimeTravelerAPI < Sinatra::Base

  #load the daily plan stored in db
  get "/#{API_VER}/dailyplan/load/:project_id/:project_day" do
    project_id = params[:project_id]
    project_day = params[:project_day]

    loads = Target.find(project_id: project_id)
    sites = {
      sites: rating_queries.map do |q|
        site[:rating] = q.rating
        site[:lat] = q.lat
        site[:lng] = q.lng
        site[:placeid] = q.placeid
        site[:types] = place.types
        site[:address] = place.address
        site[:placename] = place.placename
        {site: site}
      end
    }
    content_type 'application/json'
    sites.to_json
  end

   #find near by sites
  get "/#{API_VER}/dailyplan/findSite/:query/?" do
    query = params[:query]
    begin
      queries = Google::GooglePlaceRating.find(query: query)
      rating_queries = queries.return_rating

      sites = {
        sites: rating_queries.map do |q|
          site[:rating] = q.rating
          site[:lat] = q.lat
          site[:lng] = q.lng
          site[:placeid] = q.placeid
          site[:types] = place.types
          site[:address] = place.address
          site[:placename] = place.placename
          {site: site}
        end
      }
      content_type 'application/json'
      sites.to_json
    rescue
      halt 404, "Cannot get site data"
    end
  end

  #find near by resturants
  get "/#{API_VER}/dailyplan/findResturant/:query/?" do
    query = params[:query]
    begin
      queries = Google::GooglePlaceRating.find(query: query)
      rating_queries = queries.return_rating

      sites = {
        sites: rating_queries.map do |q|
          site[:rating] = q.rating
          site[:lat] = q.lat
          site[:lng] = q.lng
          site[:placeid] = q.placeid
          site[:types] = place.types
          site[:address] = place.address
          site[:placename] = place.placename
          {site: site}
        end
      }
      content_type 'application/json'
      sites.to_json
    rescue
      halt 404, "Cannot get site data"
    end
  end

  #find the two sites desinations -> done
  get "/#{API_VER}/dailyplan/countDistance/:origins/:destinations/?" do
    origins = params[:origins]
    destinations = params[:destinations]
    params[:mode] = "driving"
    mode = params[:mode]
    result = Google::TrafficInfo.find(origins: origins, destinations: destinations, mode: mode)

    content_type 'application/json'
    {
    	anaDistance: result.anaDistance,
    	anaDuration: result.anaDuration
    }.to_json
  end

  #find flight data -> done
  get "/#{API_VER}/dailyplan/getFlightData/:project_day/:originPlace/:destinationPlace/?" do
    params[:market] = "TW"
    params[:currency] = "TWD"
    params[:locale] = "en-GB"
    params[:outboundPartialDate] = params[:project_day]

    market = params[:market]
    currency = params[:currency]
    locale = params[:locale]
    originPlace = params[:originPlace]
    destinationPlace = params[:destinationPlace]
    outboundPartialDate = params[:outboundPartialDate]

    result = Skyscanner::FlightInfo.find(market: market, currency: currency, locale: locale,
      originPlace: originPlace, destinationPlace: destinationPlace,
      outboundPartialDate: outboundPartialDate)

    begin
    infos = result.flightInfo
    infos.map do |info|
      if info["OutboundLeg"]["CarrierIds"].empty?
        infos.delete(info)
      end
    end
    flights = {
      flights: infos.map do |info|
        flight = {}
        flight[:carrier] = info["OutboundLeg"]["CarrierIds"][0] if info["OutboundLeg"]["CarrierIds"][0]
        flight[:originPlace] = info["OutboundLeg"]["OriginId"] if info["OutboundLeg"]["OriginId"]
        flight[:destinationPlace] = info["OutboundLeg"]["DestinationId"] if info["OutboundLeg"]["DestinationId"]
        {flight: flight}
      end
    }

    content_type 'application/json'
    flights.to_json
    rescue
      content_type 'text/plain'
      halt 500, "No flight data with #{originPlace} and #{destinationPlace}"
    end
  end

  #add new sites into db
  post "/#{API_VER}/dailyplan/addSite2db" do #:project_id/:project_day/:site_name/:idx/:type/:start_time/:end_time
    data = JSON.parse request.body.read
     result = CreateTargets.call(data)
    if result.success?
      puts result
      result.value.to_json
    else
      ErrorRepresenter.new(result.value).to_status_response
    end
   end
end