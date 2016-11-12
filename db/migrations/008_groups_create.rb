# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:groups) do
      primary_key :id
	  String :group
	  String :user
    end
  end
end