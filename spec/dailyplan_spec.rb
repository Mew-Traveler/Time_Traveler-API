require_relative 'spec_helper'

describe 'Routes for dailyplans' do
  before do
    VCR.insert_cassette CASSETTE_FILE_Target, record: :new_episodes
  end
  describe 'Create New or Exists Target' do
    before do
     # TODO: find a better way
     DB[:users].delete
     DB[:projects].delete
     DB[:dailyplans].delete
     DB[:targets].delete

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
    it 'Happy: should be able to put data in Target Table' do
      post "/api/v0.1/dailyplan/addSite2db",
      {
        dailyplan_id: Dailyplan.first.id, project_day: '1', idx: '1', site_name:'新竹動物園', type: 'driving', start_time: '1200', end_time: '1300'
      }.to_json,
      'content_type'=>'application/json'
      last_response.status.must_equal 200
    end
  end
end
