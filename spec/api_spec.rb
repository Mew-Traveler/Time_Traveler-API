# frozen_string_literal: true
require_relative 'spec_helper'

describe 'API basics' do
  it 'should find configuration information' do
    app.config.AIRBNB_LOCATION.length.must_be :>, 0
    app.config.GOOGLE_ORIGIN.length.must_be :>, 0
    app.config.GOOGL_DESTINATION.length.must_be :>, 0
    app.config.GOOGLE_MODE.length.must_be :>, 0
  end


  it 'should successfully find the root route' do
    get '/'
    last_response.status.must_equal 200
  end
end

