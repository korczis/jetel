# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jetel/version'

Gem::Specification.new do |spec|
  spec.name          = 'jetel'
  spec.version       = Jetel::VERSION
  spec.authors       = ['Tomas Korcak']
  spec.email         = ['korczis@gmail.com']
  spec.summary       = 'Jetel'
  spec.description   = 'Jetel - Custom made ETL for specific needs'
  spec.homepage      = 'https://github.com/korczis/jetel'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 5.0.0.1'
  spec.add_dependency 'aws-sdk', '~> 2'
  spec.add_dependency 'couchbase', '~> 1.3', '>= 1.3.14'
  spec.add_dependency 'csv2psql', '~> 0.0.19'
  spec.add_dependency 'elasticsearch', '~> 2.0', '>= 2.0.0'
  spec.add_dependency 'gli', '~> 2.14', '>= 2.14.0'
  spec.add_dependency 'i18n'
  spec.add_dependency 'json_pure'
  spec.add_dependency 'multi_json', '~> 1.12', '>= 1.12.1'
  spec.add_dependency 'nokogiri', '~> 1.6', '>= 1.6.8'
  spec.add_dependency 'pg', '~> 0.19.0'
  spec.add_dependency 'pmap', '~> 1.1', '>= 1.1.1'
  spec.add_dependency 'rest_client', '~> 1.8', '>= 1.8.3'
  spec.add_dependency 'rubyzip', '~> 1.2', '>= 1.2.0'
  spec.add_dependency 'terminal-table', '~> 1.7', '>= 1.7.3'
  spec.add_dependency 'yajl-ruby', '~> 1.2', '>= 1.2.1'
  spec.add_dependency 'zip-zip', '~> 0.3'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'

  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop', '~> 0.35', '>= 0.35.0'
  spec.add_development_dependency 'simplecov'
end
