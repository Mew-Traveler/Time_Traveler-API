# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:sites) do
      primary_key :id
	  String :location
    end
  end
end