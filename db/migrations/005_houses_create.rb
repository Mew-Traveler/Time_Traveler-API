# frozen_string_literal: true
require 'sequel'

Sequel.migration do
  change do
    create_table(:houses) do
      primary_key :id
	  String :bnb_id
	  String :name
	  String :price
	  String :address
	  String :airbnb_link
	  String :img_url
	  String :bed
	  String :rank
    end
  end
end