# frozen_string_literal: true
require_relative 'target'

# Represents overall group information for JSON API output
class TargetsRepresenter < Roar::Decorator
  include Roar::JSON

  collection :results_atrac, extend: TargetRepresenter, class: Target
end
