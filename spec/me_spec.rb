require_relative 'spec_helper'

describe 'Test Database' do
  before do
    VCR.insert_cassette CASSETTE_FILE_USER, record: :new_episodes
  end

  after do
    VCR.eject_cassette
  end
  describe 'Create New or Exists User' do
    before do
     # TODO: find a better way
     DB[:users].delete
     DB[:projects].delete
     post 'api/v0.1/me',
          { userEmail: "yvonshih@gmail.com" }.to_json,
          'CONTENT_TYPE' => 'application/json'
     post 'api/v0.1/myproject?',
          {
            projectName: "yvonne",dateStart:"2016-12-01",dateEnd:"2016-12-06",userEmail:User.first.userEmail,groupId:"1"
          }.to_json,
          'CONTENT_TYPE' => 'application/json'

    end
    it 'HAPPY: should be able to get the data from User Table' do
      get "/api/v0.1/me/#{User.first.userEmail}"
      last_response.status.must_equal 200
      last_response.content_type.must_equal 'application/json'
      last_response.body.length.must_be :>,0
    end
    it 'SAD: should not be able to get the data from User Table' do
      get "/api/v0.1/me/123?"
      last_response.status.must_equal 404
    end
  end
end
