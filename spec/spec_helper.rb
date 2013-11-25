$:.unshift(File.dirname(__FILE__))
$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'rspec'
require 'delorean'
require 'yaml'

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
adapter = ENV['DB'] || 'sqlite'
case adapter
when 'mysql'
  require 'mysql2'
when 'postgres'
  require 'pg'
when 'sqlite'
  require 'sqlite3'
else
  require adapter
end

if ENV['RAILS'].nil?
  require File.expand_path(File.join(File.dirname(__FILE__), '../../../../config/environment.rb'))
else
  # specific rails version targeted
  # load activerecord and activesupport and plugin manually
  require 'active_record'
  require 'active_support'
  ActiveRecord::Base.configurations.update config
  ActiveRecord::Base.establish_connection(adapter)
  ActiveRecord::Base.default_timezone = :utc
  $LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
  Dir["#{$LOAD_PATH.last}/**/*.rb"].each do |path|
    require path[$LOAD_PATH.last.size + 1..-1]
  end
  require "railslove/acts/birthday/birthday"
end

load(File.dirname(__FILE__) + "/schema.rb")

RSpec.configure do |config|
  config.include Delorean
end
