# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:targets) do
      primary_key :id
      foreign_key :project_id

  	  String :project_day
	    String :idx
	    String :type
      String :start_time
      String :end_time
    end
  end
end