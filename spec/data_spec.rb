require_relative 'spec_helper'

describe 'Routes Testing' do
  SAD_LOCATION = 'ERROR'
  before do
    VCR.insert_cassette CASSETTE_FILE_AIRBNB, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end
  before do
      # TODO: find a better way
      DB[:users].delete
      DB[:projects].delete
      post 'api/v0.1/me',
           { userEmail: "test@gmail.com" }.to_json,
           'CONTENT_TYPE' => 'application/json'
      post 'api/v0.1/myproject',
           { projectName:'yvontest',dateStart:'2016-11-22',dateEnd:'2016-11-29',userId:User.first.id}.to_json,
           'CONTENT_TYPE' => 'application/json'
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
  #
  # it 'HAPPY: should be able to get data in Project Table' do
  #   get "/api/v0.1/myproject/#{Project.first.id}",
  #   # {projectId:'2'}.to_json,
  #   'content_type'=>'application/json'
  #
  #   last_response.status.must_equal 200
  #   last_response.content_type.must_equal 'application/json'
  #   rooms = JSON.parse(last_response.body)
  #   rooms.length.must_be :>,0
  #   print rooms
  # end
  # it 'SAD: should not be able to put data in Project Table' do
  #   post "/api/v0.1/myproject",
  #   {projectName:'yvon',dateStart:'anytime',dateEnd:'anytime',userId:User.first.id.to_s,projectId:Project.first.id.to_s}.to_json,
  #   'content_type'=>'application/json'
  #
  #   last_response.status.must_equal 422
  #   # last_response.body.must_include SAD_LOCATION
  # end
end
