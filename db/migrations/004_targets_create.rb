# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:target_modals) do
      primary_key :id
      foreign_key :project_id
      foreign_key :dailyplans_id

	    String :idx
	    String :type
      String :rating
      String :site_name
      String :address
      String :start_time
      String :end_time
      String :nthday
    end
  end
end
