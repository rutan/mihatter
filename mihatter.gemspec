# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mihatter/version'

Gem::Specification.new do |spec|
  spec.name          = 'mihatter'
  spec.version       = Mihatter::VERSION
  spec.authors       = ['ru_shalm']
  spec.email         = ['ru_shalm@hazimu.com']
  spec.summary       = %q{Simple Twitter crawler}
  spec.homepage      = 'https://github.com/rutan/mihatter'
  spec.licenses      = ['MIT']

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'twitter', '~> 5'
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
end
