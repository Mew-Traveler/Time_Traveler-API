# frozen_string_literal: true
require_relative 'test_helper'

describe 'Create test project' do
  it 'HAPPY: should create project for wtlin0711' do
    post "/api/v0.1/project/create",
    {"userEmail": "wtlin0711@gmail.com",
     "projectName": "LEO_TEST_PROJEXT",
     "dateStart": "1/1",
     "dateEnd": "12/31" }.to_json,
     'CONTENT_TYPE' => 'application/json'

     Project.count.must_be :>=, 1
  end
end
