# frozen_string_literal: true
require_relative 'test_helper'

describe 'Create test users' do
  it 'HAPPY: should create wtlin0711@gmail.com user' do
    post "/api/v0.1/me",
    {"userEmail": "wtlin0711@gmail.com"}.to_json,
    'CONTENT_TYPE' => 'application/json'

    User.count.must_be :>=, 1
  end
end