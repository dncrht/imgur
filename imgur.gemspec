$:.push File.expand_path('../lib', __FILE__)
require 'imgur/version'

Gem::Specification.new do |s|
  s.name          = 'imgurapi'
  s.version       = Imgur::VERSION
  s.authors       = ['Daniel Cruz Horts']
  s.homepage      = 'https://github.com/dncrht/imgur'
  s.summary       = 'Imgur authenticated API'
  s.description   = 'An interface to the Imgur authenticated API'
  s.license       = 'MIT'

  s.files = Dir['lib/**/*', 'LICENSE.txt', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']
  s.require_paths = ['lib']

  s.add_dependency 'faraday'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-byebug'
end
