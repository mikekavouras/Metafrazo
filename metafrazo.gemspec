# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metafrazo/version'

Gem::Specification.new do |spec|
  spec.name          = "metafrazo"
  spec.version       = Metafrazo::VERSION
  spec.authors       = ["Mike Kavouras"]
  spec.email         = ["kavourasm@gmail.com"]
  spec.summary       = %q{Notifies specific users if certain files have been changed}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "rest-client"
  spec.add_runtime_dependency "octokit", "~> 4.0"

end
