# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:projects) do
      primary_key :id
      foreign_key :traffic_id
      foreign_key :project_day
      foreign_key :bnb_id

	  String :project
	  String :day
	  String :location
	  String :traffic
	  String :start_time
	  String :end_time
	  String :remaining
    end
  end
end