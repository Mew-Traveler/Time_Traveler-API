# frozen_string_literal: true
require_relative 'test_helper'

describe 'Test update dailyplan' do
  it 'HAPPY: should update dailyplan in the project' do
    # data = { "project_id": Project.first.id,
    #          "nthday": Project.first.dailyplans.first.nthday,
    #          "roomId": "updated room id",
    #          "date": Project.first.dailyplans.first.date,
    #          "timeStart": "updated timeStart",
    #          "timeEnd": "updated timeEnd",
    #          "locateStart": "updated locateStart",
    #          "locateEnd": "updated locateEnd",
    #          "timeRemain": "updated timeRemain" }.to_json
    # UpdateDailyPlan.call(data)
    
    post "/api/v0.1/day/update",
    {"project_id": Project.first.id,
     "nthday": Project.first.dailyplans.first.nthday,
     "roomId": "updated room id",
     "date": Project.first.dailyplans.first.date,
     "timeStart": "updated timeStart",
     "timeEnd": "updated timeEnd",
     "locateStart": "updated locateStart",
     "locateEnd": "updated locateEnd",
     "timeRemain": "updated timeRemain" }.to_json,
     'CONTENT_TYPE' => 'application/json'


    Project.first.dailyplans.first.timeRemain.must_include 'updated timeRemain'
  end
end
