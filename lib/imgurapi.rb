# Gem dependencies
require 'faraday'
require 'json'
require 'base64'

# This gem real code
require 'imgurapi/version'
require 'imgurapi/api/base'
require 'imgurapi/api/account'
require 'imgurapi/api/image'
require 'imgurapi/communication'
require 'imgurapi/session'
require 'imgurapi/models/base'
require 'imgurapi/models/account'
require 'imgurapi/models/image'

# Rails integration
require 'imgurapi/tasks/railtie' if defined? Rails
