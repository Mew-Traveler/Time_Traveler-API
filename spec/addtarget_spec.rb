require_relative 'spec_helper'

describe 'addtarget for page5' do
  SAD_LOCATION = 'ERROR'
  before do
    VCR.insert_cassette CASSETTE_FILE_ADDTARGET, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  describe 'test for adding new target into dailyplan' do
    it 'Happy: should be able to post data in Project Table & Dailyplan Table' do
      post '/api/v0.1/addtarget/addfortest'

      last_response.status.must_equal 200
      last_response.content_type.must_equal 'application/json'
    end

    it 'Happy: should be able to post data in Target Table' do

      post '/api/v0.1/addtarget/addSite2db',
      {dailyplans_id: '1', project_day: '1', idx: '1', site_name:'新竹動物園', type: 'driving', start_time: '1200', end_time: '1300'}.to_json,
      'CONTENT_TYPE'=>'application/json'

      last_response.status.must_equal 200
      last_response.content_type.must_equal 'application/json'
    end
  end
end