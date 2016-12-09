# frozen_string_literal: true
require_relative 'spec_helper'

describe 'API basics' do
  it 'should find configuration information' do
    app.config.GOOGLE_API.length.must_be :>, 0
    app.config.AIRBNB_API.length.must_be :>, 0
    app.config.SKYSCANNER_API.length.must_be :>, 0
  end


  it 'should successfully find the root route' do
    get '/'
    last_response.status.must_equal 200
  end
end
