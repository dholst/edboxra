# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'edboxra/version'

Gem::Specification.new do |s|
  s.name        = "edboxra"
  s.version     = Edboxra::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Darrin Holst"]
  s.email       = ["darrinholst@gmail.com"]
  s.homepage    = "http://github.com/darrinholst/edboxra"
  s.summary     = "Interface to some movie box place"
  s.description = "Interface to some movie box place"

  s.rubyforge_project = "edboxra"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rest-client", "~> 1.6"
  s.add_dependency "json", "~> 1.5"
  s.add_development_dependency "webmock", "~> 1.6"
end

