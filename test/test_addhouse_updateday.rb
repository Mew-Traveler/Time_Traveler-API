# frozen_string_literal: true
require_relative 'test_helper'

describe 'Test create house and update choosen dailyplan' do
  it 'HAPPY: should update dailyplan in the project' do
    
    post "/api/v0.1/day/newroom",
    {"dailyplanInfo": {"project_id": Project.first.id,
                       "nthday": Project.first.dailyplans.first.nthday,
                       "roomId": "updated room id",
                       "date": Project.first.dailyplans.first.date,
                       "timeStart": "updated timeStart",
                       "timeEnd": "updated timeEnd",
                       "locateStart": "updated locateStart",
                       "locateEnd": "updated locateEnd",
                       "timeRemain": "after add house"},
     "roomInfo": {"id": "empty",
                  "name": "empty",
                  "price": "empty",
                  "address": "empty",
                  "airbnb_link": "empty",
                  "roomImg": "empty",
                  "bed": "empty",
                  "roomRank": "empty"} 
    }.to_json,
    'CONTENT_TYPE' => 'application/json'


    Project.first.dailyplans.first.timeRemain.must_include 'after add house'
    House.all.length.must_be :>, 0
  end
end
