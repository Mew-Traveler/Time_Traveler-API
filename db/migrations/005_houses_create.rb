# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:houses) do
      primary_key :id
	  String :roomId
	  String :roomName
	  String :roomPrice
	  String :address
	  String :airbnb_link
	  String :roomImg
	  String :bed
	  String :roomRank
    end
  end
end
