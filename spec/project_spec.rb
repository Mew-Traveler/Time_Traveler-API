require_relative 'spec_helper'

describe 'Routes for airbnb' do
  SAD_LOCATION = 'ERROR'
  before do
    VCR.insert_cassette CASSETTE_FILE_AIRBNB, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  it 'HAPPY: should be able to put data in User Table' do
    get "/api/v0.1/myproject/2",
    # {projectId:'2'}.to_json,
    'content_type'=>'application/json'

    last_response.status.must_equal 200
    last_response.content_type.must_equal 'application/json'
    rooms = JSON.parse(last_response.body)
    rooms.length.must_be :>,0
    print rooms
  end
  # it 'SAD: should not be able to put data in User Table' do
  #   post "/api/v0.1/myproject",
  #   {projectName:'yvon',dateStart:'2016-11-20',dateEnd:'2016-11-23',userId:'5',groupId:'2'}.to_json,
  #   'content_type'=>'application/json'

  #   last_response.status.must_equal 422
  #   # last_response.body.must_include SAD_LOCATION
  # end
  it 'Happy: should be able to put data in DailyPlan Table' do
    post "/api/v0.1/myproject/dailyplan",
    {projectId:Project.first.id,roomId:'000001',nthday:'1',timeStart:'8:00',timeEnd:'17:00',locateStart:'台北',locateEnd:'新竹',timeRemain:'500'}.to_json,
    'content_type'=>'application/json'

    last_response.status.must_equal 200
    # last_response.body.must_include SAD_LOCATION
  end
  it 'Happy: should be able to get data in DailyPlan Table' do
    get "/api/v0.1/myproject/dailyplan/#{Project.first.id}/1"

    last_response.status.must_equal 200
    last_response.content_type.must_equal 'application/json'
    rooms = JSON.parse(last_response.body)
    rooms.length.must_be :>,0
  end
end
