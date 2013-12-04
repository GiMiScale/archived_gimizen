# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gimizen/version'

Gem::Specification.new do |gem|
  gem.name          = 'gimizen'
  gem.version       = Gimizen::VERSION
  gem.license       = 'Apache License, Version 2.0'
  gem.authors       = ['GiMiScale', 'Nick den Engelsman']
  gem.email         = ['nick.denengelsman@gimiscale.com']
  gem.description   = %q{API wrapper for Zendesk}
  gem.summary       = %q{Creating tickets for Zendesk should be as simple as 'zen'.}
  gem.homepage      = 'https://github.com/GiMiScale/gimizen'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.post_install_message = 'Thanks for installing!'

  gem.add_runtime_dependency 'httparty', '~> 0.8.3'
  gem.add_runtime_dependency 'json', '~> 1.8.0'
  gem.add_runtime_dependency 'hash_symbolizer', '~> 1.0.1'
  
  gem.add_development_dependency 'rspec', '~> 2.13.0'
  gem.add_development_dependency 'capybara', '~> 2.1.0'
  gem.add_development_dependency 'vcr', '~> 2.4.0'
  gem.add_development_dependency 'webmock', '~> 1.8.0'
  gem.add_development_dependency 'simplecov', '~> 0.7.1'
end
