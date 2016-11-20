# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :userEmail
    end
  end
end
