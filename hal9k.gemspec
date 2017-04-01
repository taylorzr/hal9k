# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hal9k/version'

Gem::Specification.new do |spec|
  spec.name          = "hal9k"
  spec.version       = Hal9k::VERSION
  spec.authors       = ["Zach Taylor"]
  spec.email         = ["taylorzr@gmail.com"]

  spec.summary       = %q{Quickly build powerful command line tools}
  spec.homepage      = "https://github.com/taylorzr/hal9k"

  spec.files         = `git ls-files -z`.split("\x0")
                         .reject { |f| f.match(%r{^(test|spec|features)/}) }
                         .reject { |f| f.match(/_spec\.rb$/) }

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug"

  spec.add_dependency "activesupport"
end
