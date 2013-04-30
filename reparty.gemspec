# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reparty/version'

Gem::Specification.new do |spec|
  spec.name          = "reparty"
  spec.version       = Reparty::VERSION
  spec.authors       = ["Tim Dorr"]
  spec.email         = ["reparty@timdorr.com"]
  spec.description   = %q{Stupid easy business analytics}
  spec.summary       = %q{Stupid easy business analytics}
  spec.homepage      = "https://github.com/timdorr/reparty"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", "~> 3.2"
  spec.add_dependency "actionmailer", "~> 3.2"
  spec.add_dependency "rmagick"
  spec.add_dependency "gruff"
  spec.add_dependency "groupdate"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "letter_opener"
end
