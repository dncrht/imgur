# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imgur/version'

Gem::Specification.new do |gem|
  gem.name          = 'imgur'
  gem.version       = Imgur::VERSION
  gem.authors       = ['dncrht']
  gem.description   = %q{An interface to the Imgur authenticated API}
  gem.summary       = %q{Imgur authenticated API}
  gem.homepage      = 'https://github.com/dncrht/imgur'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  
  gem.add_dependency 'oauth', '>= 0.4.5'
  gem.add_dependency 'json', '>= 1.6.4'
end
