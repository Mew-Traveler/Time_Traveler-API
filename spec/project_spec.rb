require_relative 'spec_helper'

describe 'Routes Testing' do
  SAD_LOCATION = 'ERROR'
  before do
    VCR.insert_cassette CASSETTE_FILE_PROJECT, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end

  describe 'Create New or Exists Projects' do
    before do
     # TODO: find a better way
     DB[:users].delete
     DB[:projects].delete
     DB[:dailyplans].delete

     post 'api/v0.1/me',
          { userEmail: "yvonshih@gmail.com" }.to_json,
          'CONTENT_TYPE' => 'application/json'
     post 'api/v0.1/myproject?',
          {
            projectName: "yvonne",dateStart:"2016-12-01",dateEnd:"2016-12-06",userEmail:User.first.userEmail,groupId:"1"
          }.to_json,
          'CONTENT_TYPE' => 'application/json'
     post "/api/v0.1/myproject/dailyplan",
          {
            projectId:Project.first.id,roomId:'000001',nthday:'1',timeStart:'8:00',timeEnd:'17:00',locateStart:'台北',locateEnd:'新竹',timeRemain:'8'
          }.to_json,
          'CONTENT_TYPE' => 'application/json'

    end

    it 'HAPPY: should be able to get data from Project Table' do
      get "/api/v0.1/myproject/#{Project.first.id}",

      'content_type'=>'application/json'
      last_response.status.must_equal 200
      last_response.content_type.must_equal 'application/json'
      last_response.body.length.must_be :>,0
    end
    it 'SAD: should not be able to put data in Project Table' do
      post "/api/v0.1/myproject",
      {
        projectName:Project.first.projectName.to_s,dateStart:'anytime',dateEnd:'anytime',userEmail:User.first.userEmail.to_s,projectId:Project.first.id.to_s
      }.to_json,
      'content_type'=>'application/json'

      last_response.status.must_equal 409
    end
    it 'Happy: should be able to get data in DailyPlan Table' do
      get "/api/v0.1/myproject/dailyplan/#{Project.first.id}/1"

      last_response.status.must_equal 200
      last_response.content_type.must_equal 'application/json'
      rooms = JSON.parse(last_response.body)
      rooms.length.must_be :>,0
    end
  end
end
