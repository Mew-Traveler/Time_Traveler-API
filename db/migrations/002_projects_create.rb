# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:projects) do
      primary_key :id

      String :userEmail
      String :projectName
      String :dateStart
      String :dateEnd
      String :groupId
    end
  end
end
