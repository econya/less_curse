# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'less_curse/version'

Gem::Specification.new do |spec|
  spec.name          = "less_curse"
  spec.version       = LessCurse::VERSION
  spec.authors       = ["Felix Wolfsteller"]
  spec.email         = ["felix.wolfsteller@gmail.com"]

  spec.summary       = %q{ncurses abstraction layer for terminal-based applications.}
  spec.description   = %q{LessCurse is a ncurses abstraction layer for terminal-based user interfaces.}
  spec.homepage      = "https://github.com/econya/less_curse"
  spec.license       = "GPLv3+"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ffi-ncurses", '~> 0.4'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
