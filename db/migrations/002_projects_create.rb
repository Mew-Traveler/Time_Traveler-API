# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:projects) do
      primary_key :id
    
      String :traffic_id
      String :project_day
      String :bnb_id

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