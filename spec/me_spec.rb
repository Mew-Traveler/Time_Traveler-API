require_relative 'spec_helper'

describe 'Routes for airbnb' do
  SAD_LOCATION = 'ERROR'
  before do
    VCR.insert_cassette CASSETTE_FILE_AIRBNB, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  it 'HAPPY: should be able to get the data from User Table' do
    get "/api/v0.1/me/#{User.first.userEmail}"
    # get "api/v0.1/airbnb/#{app.config.AIRBNB_LOCATION}"

    last_response.status.must_equal 200
    last_response.content_type.must_equal 'application/json'
    rooms = JSON.parse(last_response.body)
    rooms.length.must_be :>,0
  end
  it 'SAD: should not be able to get the data from User Table' do
    get "/api/v0.1/me/123?"

    last_response.status.must_equal 404
    # last_response.body.must_include SAD_LOCATION
  end

end
