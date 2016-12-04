require_relative 'spec_helper'

describe 'Routes for room' do
  before do
    VCR.insert_cassette CASSETTE_FILE_ROOM, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  describe 'Get house data from DB' do
    before do
      DB[:houses].delete
      post "api/v0.1/house/generate/test/?"
    end

    it 'HAPPY: should get house from db by correct room id' do
    	
      get "api/v0.1/house/1234/?"
      last_response.status.must_equal 200
      last_response.content_type.must_equal 'application/json'
      house = JSON.parse(last_response.body)
      house['roomId'].must_be :>,0
      house['roomName'].must_be :>,0
      house['roomPrice'].must_be :>,0
      house['address'].must_be :>,0
      house['airbnb_link'].must_be :>,0
      house['roomImg'].must_be :>,0
      house['bed'].must_be :>,0
      house['roomRank'].must_be :>,0
    end

    it 'SAD: should not get house from db by wrong room id' do

      get "api/v0.1/house/-1/?"
      last_response.status.must_equal 404
      last_response.content_type.must_equal 'text/plain'
      body.must_include 'house'
    end
  end

  describe 'Write house data to DB' do
    it 'HAPPY: should write the house successful with correct params' do
      post "api/v0.1/house/?",
      {
        roomId: 'new_roomId',
        roomName: 'new_roomName',
        roomPrice: 'new_roomPrice',
        address: 'new_address',
        airbnb_link: 'new_airbnb_link',
        roomImg: 'new_roomImg',
        bed:  'new_bed',
        roomRank: 'new_roomRank'
      }.to_json,
      'content_type'=>'application/json'

      last_response.status.must_equal 200
      last_response.content_type.must_equal 'application/json'
      house = JSON.parse(last_response.body)
      house['roomId'].must_be :>,0
      house['roomName'].must_be :>,0
      house['roomPrice'].must_be :>,0
      house['address'].must_be :>,0
      house['airbnb_link'].must_be :>,0
      house['roomImg'].must_be :>,0
      house['bed'].must_be :>,0
      house['roomRank'].must_be :>,0
      
    end
  end

end