# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rss-growl/version"

Gem::Specification.new do |s|
  s.name        = "rss-growl"
  s.version     = Rss::Growl::VERSION
  s.authors     = ["Daniel Bretoi"]
  s.email       = ["nefar@otherware.org"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "rss-growl"
  s.add_dependency 'simple-rss'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
