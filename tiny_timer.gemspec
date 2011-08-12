# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tiny_timer/version"

Gem::Specification.new do |s|
  s.name        = "tiny_timer"
  s.version     = TinyTimer::VERSION
  s.authors     = ["Tao Zhang"]
  s.email       = ["birdbluebloc@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{ a very simple gem to print elapsed time for pieces of code or rake tasks }
  s.description = %q{ with handy global methods, print out the running time as your codes run }
  s.license     = 'MIT'

  # s.rubyforge_project = "tiny_timer"

  s.add_dependency('rake', ">= 0.8.7")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
