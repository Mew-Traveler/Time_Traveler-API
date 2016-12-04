require_relative 'spec_helper'

describe 'Routes for airbnb' do
  SAD_LOCATION = 'ERROR'
  before do
    VCR.insert_cassette CASSETTE_FILE_AIRBNB, record: :new_episodes
  end

  it 'Happy: should be able to put data in Target Table' do
    post "/api/v0.1/dailyplan/addSite2db",
    {dailyplan_id: Dailyplan.first.id, project_day: '1', idx: '1', site_name:'新竹動物園', type: 'driving', start_time: '1200', end_time: '1300'}.to_json,
    'CONTENT_TYPE'=>'application/json'

    last_response.status.must_equal 200
    last_response.content_type.must_equal 'application/json'
  end
end