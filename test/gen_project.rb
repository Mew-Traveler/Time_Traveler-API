# frozen_string_literal: true
require_relative 'test_helper'

describe 'Create test project' do
  it 'HAPPY: should create project for wtlin0711' do
    post "/api/v0.1/project/create",
    {"userEmail": "wtlin0711@gmail.com",
     "projectName": "LEO_TEST_PROJEXT",
     "dateStart": "1/1",
     "dateEnd": "1/3" }.to_json,
     'CONTENT_TYPE' => 'application/json'

     Project.count.must_be :>=, 1
  end

  it 'HAPPY: should create project for wtlin0711' do
    post "/api/v0.1/project/create",
    {"userEmail": "wtlin0711@gmail.com",
     "projectName": "WTLIN_PROJECT",
     "dateStart": "1/4",
     "dateEnd": "1/8" }.to_json,
     'CONTENT_TYPE' => 'application/json'

     Project.count.must_be :>=, 1
  end

  it 'HAPPY: should create project for wtlin0711' do
    post "/api/v0.1/project/create",
    {"userEmail": "wtlin0711@gmail.com",
     "projectName": "HAPPY_TRIP",
     "dateStart": "1/29",
     "dateEnd": "2/2" }.to_json,
     'CONTENT_TYPE' => 'application/json'

     Project.count.must_be :>=, 1
  end
end
