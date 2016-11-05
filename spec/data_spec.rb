re_relative 'spec_helper.rb'

describe 'Routes for airbnb' do
  SAD_LOCATION = 'ERROR'

  before do
    VCR.insert_cassette CASSETTE_FILE_AIRBNB, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  it 'HAPPY: should be able to get the data from Airbnb' do
    get "api/v0.1/airbnb/#{app.config.AIRBNB_LOCATION}"

    last_response.status.must_equal 200
    last_response.content_type.must_equal 'application/json'
    rooms = JSON.parse(last_response.body)
    rooms.length.must_be :>,0
  end

  it 'SAD: should be able to get the data from Airbnb' do
    get "api/v0.1/airbnb/#{SAD_LOCATION}"

    last_response.status.must_equal 404
    last_response.body.must_include SAD_LOCATION
  end
end

describe 'Routes for google' do
  SAD_ORIGIN = 'ERROR_ORIGIN'
  SAD_DESTINATION = 'ERROR_DESTINATION'
  SAD_MODE = 'ERROR_MODE'

  before do
    VCR.insert_cassette CASSETTE_FILE_GOOGLE, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  it 'HAPPY: should be able to get the data from Google' do
    get "api/v0.1/google/#{GOOGLE_ORIGIN}&#{GOOGL_DESTINATION}&{GOOGLE_MODE}"

    last_response.status.must_equal 200
    last_response.content_type.must_equal 'application/json'
    data = JSON.parse(last_response.body)
    data.length.must_be :>,0
  end

  it 'SAD: should be able to get the data from Google' do
    get "api/v0.1/google/#{SAD_ORIGIN}&#{SAD_DESTINATION}&{SAD_MODE}"

    last_response.status.must_equal 404
    last_response.content_type.must_equal 'application/json'
    last_response.body.must_include SAD_LOCATION
    last_response.body.must_include SAD_DESTINATION
    last_response.body.must_include SAD_MODE
  end
end

