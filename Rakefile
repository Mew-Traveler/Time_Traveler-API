# frozen_string_literal: true
require 'rake/testtask'

task :default do
  puts `rake -T`
end

Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/*_spec.rb'
  t.warning = false
end

Rake::TestTask.new(:testcase) do |t|
  t.pattern = 'test/testcase.rb'
  t.warning = false
end

Rake::TestTask.new(:clear) do |t|
  t.pattern = 'test/earse.rb'
  t.warning = false
end

desc 'delete cassette fixtures'
task :wipe do
  sh 'rm spec/fixtures/cassettes/*.yml' do |ok, _|
    puts(ok ? 'Cassettes deleted' : 'No casseettes found')
  end
end

namespace :db do
  desc 'Run database migrations'
  task :migrate do
    require 'sequel'
    require_relative 'init'
    Sequel.extension :migration
    puts "Migrating to latest for: #{ENV['RACK_ENV'] || 'development'}"
    Sequel::Migrator.run(DB, 'db/migrations')
  end

  desc 'Reset migrations (full rollback and migration)'
  task :reset do
    require 'sequel'
    require_relative 'init'
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'db/migrations', target: 0)
    Sequel::Migrator.run(DB, 'db/migrations')
  end
end

namespace :quality do
  CODE = 'app.rb'

  desc 'run all quality checks'
  task all: [:rubocop, :flog, :flay]

  task :flog do
    sh "flog #{CODE}"
  end

  task :flay do
    sh "flay #{CODE}"
  end

  task :rubocop do
    sh 'rubocop'
  end
end
