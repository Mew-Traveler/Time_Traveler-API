# frozen_string_literal: true
require_relative 'test_helper'

describe 'Test get dailyplan' do
  it 'HAPPY: should get dailyplan in the project' do
    get "/api/v0.1/project/wtlin0711@gmail.com/" + Project.first.id.to_s + "/1?"

    last_response.status.must_equal 200
    last_response.body.length.must_be :>, 0
  end
end
