# frozen_string_literal: true
require_relative 'test_helper'

describe 'Delete all database' do
  describe 'Clear the page and posting table' do
  	before do
      DB[:projects].delete
      DB[:dailyplans].delete
      DB[:users].delete
    end

    it 'HAPPY: database should be empty' do
      Project.count.must_equal 0
      Dailyplan.count.must_equal 0
      User.count.must_equal 0
    end
  end

end



    