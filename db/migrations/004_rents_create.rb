# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:rents) do
      primary_key :id
      
      String :bnb_id_1
	  String :bnb_id_2
	  String :bnb_id_3
	  String :bnb_id_4
	  String :bnb_id_5
	  String :bnb_id_6
	  String :bnb_id_7
	  String :bnb_id_8
	  String :bnb_id_9
	  String :bnb_id_10

	  String :location
    end
  end
end