# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "railslove/acts/birthday/version"

Gem::Specification.new do |s|
  s.name        = "birthday"
  s.version     = Railslove::Acts::Birthday::VERSION
  s.authors     = ["Mike Połtyn"]
  s.email       = ["mike@railslove.com"]
  s.homepage    = ""
  s.summary     = %q{Birthday gem allows to tag date and datetime fields in ActiveRecord}
  s.description = %q{Birthday gem creates convienent methods for date and datetime fields in ActiveRecord, making it possible to look for birthdays without a hassle.}

  s.rubyforge_project = "birthday"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rake"
  s.add_development_dependency "mysql2", '< 0.3'
  s.add_development_dependency "delorean"
  s.add_runtime_dependency "activerecord"
  s.add_runtime_dependency "activesupport"
end
