require 'bundler'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

desc 'Test the gem'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task :default => :test