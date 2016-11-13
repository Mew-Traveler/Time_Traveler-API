# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:owners) do
      primary_key :id

      String :project
      String :group
      String :owner
    end
  end
end
