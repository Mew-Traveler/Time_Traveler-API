# frozen_string_literal: true
require 'dry-monads'
require 'dry-container'
require 'dry-transaction'
require 'VIAJERO'

Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
  require file
end
