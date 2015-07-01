# Gem dependencies
require 'faraday'
require 'json'
require 'base64'

# Some nice extensions to base classes
require 'imgur/extensions/array'
require 'imgur/extensions/hash'
require 'imgur/extensions/string'

# This gem real code
require 'imgur/version'
require 'imgur/api'
require 'imgur/communication'
require 'imgur/session'
require 'imgur/models/base'
require 'imgur/models/account'
require 'imgur/models/image'

# Gem's container module
module Imgur

  HOST = 'https://api.imgur.com'

end
