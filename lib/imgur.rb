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
require 'imgur/api/base'
require 'imgur/api/account'
require 'imgur/api/image'
require 'imgur/communication'
require 'imgur/session'
require 'imgur/models/base'
require 'imgur/models/account'
require 'imgur/models/image'
