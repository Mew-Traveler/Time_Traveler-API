# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:flights) do
      primary_key :id
      String :traffic_id
	    String :flight
	    String :candidate
    end
  end
end
