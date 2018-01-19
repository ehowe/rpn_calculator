# frozen_string_literal: true

require File.expand_path('../lib/rpn', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Eugene Howe']
  gem.email         = ['eugene@xtreme-computers.net']
  gem.description   = 'Reverse Polish Notation Calculator'
  gem.summary       = 'Provides REPL for evaluating Reverse Polish Notation Arithmetic'

  gem.files                 = `git ls-files`.split($ORS)
  gem.executables           = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files            = gem.files.grep(%r{^(test|spec|features)/})
  gem.name                  = 'rpn'
  gem.require_paths         = ['lib']
  gem.version               = Rpn::VERSION
  gem.required_ruby_version = '>= 2.5.0'

  gem.add_development_dependency 'rspec', '~> 3.7'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'simplecov'
end
