# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'version'

Gem::Specification.new do |spec|
  spec.name          = 'mumuki-qsim-runner'
  spec.version       = QsimVersionHook::VERSION
  spec.authors       = ['Federico Aloi']
  spec.email         = ['fede@mumuki.org']
  spec.summary       = 'Qsim Runner for Mumuki'
  spec.homepage      = 'http://github.com/mumuki/mumuki-qsim-runner'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/**']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'mumukit', '~> 2.6'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'mumukit-bridge', '~> 3.0'
end
