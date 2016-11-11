# frozen_string_literal: true
source 'https://rubygems.org'

gem 'sinatra'
gem 'puma'
gem 'json'
gem 'econfig'

gem 'Time_Traveler', '0.1.60'

gem 'sequel'

group :develop, :test do
  gem 'sqlite3'
end

group :develop, :test do
  gem 'pry-byebug'
end

group :test do
  gem 'minitest'
  gem 'minitest-rg'

  gem 'rack-test'
  gem 'rake','<2.0'
  gem 'vcr'
  gem 'webmock'
end
