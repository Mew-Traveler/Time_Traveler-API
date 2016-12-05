# frozen_string_literal: true

# TimeTravelerAPI web service
class TimeTravelerAPI < Sinatra::Base 



  #load the daily plan stored in db
  get "/#{API_VER}/addtarget/load/:project_id/:project_day" do
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
  get "/#{API_VER}/addtarget/findSite/:query/?" do
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
  get "/#{API_VER}/addtarget/findResturant/:query/?" do
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
  get "/#{API_VER}/addtarget/countDistance/:origins/:destinations/?" do
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
  get "/#{API_VER}/addtarget/getFlightData/:project_day/:originPlace/:destinationPlace/?" do
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
  post "/#{API_VER}/addtarget/addSite2db/?" do #:project_id/:project_day/:site_name/:idx/:type/:start_time/:end_time
  	body_params = JSON.parse request.body.read
    newSite_dailyplans_id = body_params['dailyplans_id']
    newSite_project_day = body_params['project_day']
    newSite_idx = body_params['idx']
    newSite_site_name = body_params['site_name']
    newSite_type = body_params['type']
    newSite_start_time = body_params['start_time']
    newSite_end_time = body_params['end_time']

    begin
      if (Project.count == 0)
        halt 422, "plan (addtarget: #{newSite_dailyplans_id})not found"
      end
    end

    begin
      newSite = Target.create(dailyplans_id: newSite_dailyplans_id, project_day: newSite_project_day, idx: newSite_idx, site_name: newSite_site_name, type: newSite_type, start_time: newSite_start_time, end_time: newSite_end_time)
      content_type 'application/json'
      newSite.to_json
    rescue
      content_type 'text/plain'
      halt 500, "Cannot create site (id: #{newSite_site_name})"
    end
  end

  post "#{API_VER}/addtarget/addfortest/" do
    Project.create(userId: 'test', projectName: 'test', dateStart: '2016-12-30', dateEnd: '2017-1-5', groupId: 'NULL')
    Dailyplan.create(project_id: Project.first.id, roomId: '1', nthday: '1', date: '2016-12-30', timeStart: '0800', timeEnd: '1700', locateStart: 'Taipei', locateEnd: 'Hsinchu', timeRemain: '9')
    begin
      if (Project.empty? == true)
        halt 424, "fail to create new project"
      end
    end
  end
end
