# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:dailyplans) do
      primary_key :id
      foreign_key :project_id
      
      String :roomId
      String :nthday
      String :date
      String :timeStart
      String :timeEnd
      String :locateStart
      String :locateEnd
      String :timeRemain
    end
  end
end
