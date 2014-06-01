# Gem dependencies
require 'faraday'
require 'json'

# Some nice extensions to base classes
require 'imgur/extensions/array'
require 'imgur/extensions/hash'
require 'imgur/extensions/string'

# This gem real code
require 'imgur/version'
require 'imgur/api'
require 'imgur/communication'
require 'imgur/image'
require 'imgur/links'
require 'imgur/session'

# Gem's container module
module Imgur

  HOST = 'https://api.imgur.com'
  IMAGE_URL = 'http://i.imgur.com/'
  IMAGE_EXTENSION = 'jpg' # jpg is the default extension for every Imgur image

end
