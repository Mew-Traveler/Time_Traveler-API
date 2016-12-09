# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:dailyplans) do
      primary_key :id
      # foreign_key :projectId

      String :roomId
      String :nthday
      String :date
      String :timeStart
      String :timeEnd
      String :locateStart
      String :locateEnd
      String :timeRemain
      String :projectId
    end
  end
end
