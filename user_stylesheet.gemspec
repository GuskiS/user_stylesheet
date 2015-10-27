# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'user_stylesheet'
  spec.version       = '0.0.3'
  spec.date          = '2015-10-27'
  spec.summary       = 'Dynamic user stylesheets'
  spec.description   = 'Dynamic user stylesheets'
  spec.authors       = ['GuskiS']
  spec.email         = 'edvards@lazdans.lv'
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]
  spec.homepage      = 'https://github.com/GuskiS/user_stylesheet'
  spec.license       = 'MIT'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'sprockets'
  spec.add_development_dependency 'sass'
end
