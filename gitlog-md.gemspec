# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'gitlog-md/version'

Gem::Specification.new do |s|
  s.name        = "gitlog-md"
  s.version     = GitlogMD::Version::STRING
  s.authors     = ["Puppetlabs"]
  s.email       = ["qe-team@puppetlabs.com"]
  s.homepage    = "https://github.com/puppetlabs/gitlog-md"
  s.summary     = %q{Let's generate a HISTORY.md file!}
  s.description = %q{Puppetlabs tools for creating markdown HISTORY.md from git log}
  s.license     = 'Apache2'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Testing dependencies
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rspec-its'
  s.add_development_dependency 'fakefs', '~> 0.6'
  s.add_development_dependency 'rake', '~> 10.1'
  s.add_development_dependency 'simplecov'

  # Documentation dependencies
  s.add_development_dependency 'yard'

  # Run time dependencies
  s.add_runtime_dependency 'gitlab-grit'
end
