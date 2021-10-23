require 'rake'
require 'active_record'
require 'yaml/store'
require 'ostruct'
require 'date'
require "tty-prompt"
require 'nokogiri'
require 'open-uri'
require 'pry'


# require 'bundler/setup'
# Bundler.require

require_relative '../lib/fantacalcio.rb'
require_relative '../lib/player.rb'
require_relative '../lib/team.rb'
require_relative '../lib/scraper.rb'


# put the code to connect to the database here
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/serieA.sqlite"
)
