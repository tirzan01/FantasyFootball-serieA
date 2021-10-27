require 'rake'
require 'active_record'
require 'yaml/store'
require 'ostruct'
require 'date'
require "tty-prompt"
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'rainbow'


# require 'bundler/setup'
# Bundler.require

require_relative '../lib/fantasy_footbal_serie_a/player.rb'
require_relative '../lib/fantasy_footbal_serie_a/team.rb'
require_relative '../lib/fantasy_footbal_serie_a/scraper.rb'
require_relative '../lib/fantasy_footbal_serie_a/cli.rb'


# put the code to connect to the database here
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/serieA.sqlite"
)
