# frozen_string_literal: true

# Loads data from Facebook group to database
class FindTarget
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    puts "api-dailyplan.rb//findSite"
    puts params

    atracs = Google::GooglePlaceRating.find(query:params[:query])
    atracs = atracs.attracs.map do |atrac|
      TargetRepresenter.new(Target.new).from_json(atrac.to_json.to_s)
    end
    results = Targets.new(atracs)
    Right(results)

  end
end
