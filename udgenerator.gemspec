# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'udgenerator/version'

Gem::Specification.new do |spec|
  spec.name          = "udgenerator"
  spec.version       = Udgenerator::VERSION
  spec.authors       = ["akuraru"]
  spec.email         = ["akuraru@gmail.com"]

  spec.summary       = %q{generate NSUserDefaults rapper}
  spec.description   = %q{generate a wrapper of NSUserDefaults from type and name}
  spec.homepage      = "https://github.com/akuraru/UserDefaultsCreator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
