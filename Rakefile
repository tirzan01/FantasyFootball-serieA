# frozen_string_literal: true

# require "bundler/gem_tasks"
require "rspec/core/rake_task"
require_relative './lib/fantasy_footbal_serie_a.rb'
require 'sinatra/activerecord/rake'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :console do
  require 'irb'
  ARGV.clear
  IRB.start
end
