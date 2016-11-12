# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:rents) do
      primary_key :id
      foreign_key :bnb_id_1
	  foreign_key :bnb_id_2
	  foreign_key :bnb_id_3
	  foreign_key :bnb_id_4
	  foreign_key :bnb_id_5
	  foreign_key :bnb_id_6
	  foreign_key :bnb_id_7
	  foreign_key :bnb_id_8
	  foreign_key :bnb_id_9
	  foreign_key :bnb_id_10

	  String :location
    end
  end
end