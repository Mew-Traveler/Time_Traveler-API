# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:owners) do
      primary_key :id
      foreign_key :project
      
      String :owner
      String :group
    end
  end
end