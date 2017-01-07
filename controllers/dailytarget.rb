
#find near by sites
class TimeTravelerAPI < Sinatra::Base

  get "/#{API_VER}/dailyplan/findSite/:query?" do
   puts "api-dailyplan.rb//findSite"
   puts params
   results_atrac = FindTarget.call(params)
   if results_atrac.success?
     puts "results_atrac.success?"
     content_type 'application/json'
     # results_atrac.value.to_json
    #  puts results_atrac.value
     TargetsRepresenter.new(results_atrac.value).to_json

     # AtraccionesRepresenter.new(Atracciones.new).from_json(results_atrac.value.to_json).to_json
   else
     ErrorRepresenter.new(results_atrac.value).to_status_response
   end
 end
end
