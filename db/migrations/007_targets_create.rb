# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:targets) do
      primary_key :id

	  String:site_id
	  
	  String :project_day
	  String :idx
	  String :type
	  String :spend_time
    end
  end
end