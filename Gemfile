# frozen_string_literal: true
source 'https://rubygems.org'
ruby '2.3.1'

gem 'sinatra'
gem 'puma'
gem 'json'
gem 'econfig'
gem 'Time_Traveler', '0.1.72'
gem 'sequel'
gem 'rake'
gem 'roar'
gem 'multi_json'
gem 'dry-monads'
gem 'dry-container'
gem 'dry-transaction'
gem 'shoryuken'
gem 'aws-sdk','~> 2'

group :development, :test do
  gem 'sqlite3'
end

group :development do
  gem 'rerun'

  gem 'flog'
  gem 'flay'
end

group :test do
  gem 'minitest'
  gem 'minitest-rg'

  gem 'rack-test'

  gem 'vcr'
  gem 'webmock'
end

group :development, :production do
  gem 'tux'
  gem 'hirb'
end

group :production do
  gem 'pg'
end
