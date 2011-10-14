$:.unshift(File.dirname(__FILE__))
$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'test/unit'
require 'rubygems'
require 'rspec'

def fixture(file_name)
  File.read(fixture_path(file_name))
end

def fixture_path(file_name)
  File.expand_path(File.dirname(__FILE__)) + "/fixtures/#{file_name}"
end

if ENV['RAILS'].nil?
  require File.expand_path(File.join(File.dirname(__FILE__), '../../../../config/environment.rb'))
else
  # specific rails version targeted
  # load activerecord and activesupport and plugin manually
  require 'active_record'
  require 'active_support'
  $LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
  Dir["#{$LOAD_PATH.last}/**/*.rb"].each do |path| 
    require path[$LOAD_PATH.last.size + 1..-1]
  end
  require "railslove/acts/birthday/birthday"
end
require 'delorean'
require 'yaml'
config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
adapter = ENV['DB'] || 'mysql'
case adapter
when 'mysql'
  require 'mysql2'
else
  require adapter
end

ActiveRecord::Base.configurations.update config
#ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(config[adapter])

load(File.dirname(__FILE__) + "/schema.rb")

RSpec.configure do |config|
  config.include Delorean
end