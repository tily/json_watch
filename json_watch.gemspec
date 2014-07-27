# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_watch/version'

Gem::Specification.new do |spec|
  spec.name          = "json_watch"
  spec.version       = JsonWatch::VERSION
  spec.authors       = ["tily"]
  spec.email         = ["tidnlyam@gmail.com"]
  spec.summary       = %q{small utility to watch json changes}
  spec.description   = %q{small utility to watch json changes}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_dependency "json"
  spec.add_dependency "json-compare"
end
