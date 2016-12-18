# frozen_string_literal: true
require_relative 'atraccione'

# Represents overall group information for JSON API output
class AtraccionesRepresenter < Roar::Decorator
  include Roar::JSON

  collection :results_atrac, extend: AtraccioneRepresenter, class: Atraccione
end
