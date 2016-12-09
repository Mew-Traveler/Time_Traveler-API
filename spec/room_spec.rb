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
      post '/api/v0.1/house',
       {
        roomId: Dailyplan.first.roomId, roomName: "yvon", roomPrice: "100",
        address: "Calle Yvon", airbnb_link: "air@", roomImg: "room@", bed:  "3", roomRank: "1"
       }.to_json,
       'CONTENT_TYPE' => 'application/json'
      end
    it 'HAPPY: should get house from db by correct room id' do
      get "api/v0.1/house/#{House.first.roomId}/?"
      last_response.status.must_equal 200
      last_response.content_type.must_equal 'application/json'
      last_response.body.length.must_be :>,0
    end
    #
    it 'SAD: should not get house from db by wrong room id' do
      get "api/v0.1/house/-1/?"
      last_response.status.must_equal 404
      last_response.content_type.must_equal 'text/html;charset=utf-8'
    end
  end
end
