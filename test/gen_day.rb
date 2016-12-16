# frozen_string_literal: true
require_relative 'test_helper'

describe 'Create test day' do
  it 'HAPPY: should create day for project of wtlin0711' do
    post "/api/v0.1/day/create",
    {"project_id": Project.first.id,
     "nthday": "1",
     "date": Project.first.dateStart }.to_json,
     'CONTENT_TYPE' => 'application/json'

     Dailyplan.count.must_be :>=, 1
  end
end
