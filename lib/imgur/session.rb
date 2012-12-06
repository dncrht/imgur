module Imgur
  
  class Session
    include API
    include Communication
    
    # Creates the session instance that handles all the API calls to Imgur
    def initialize(credentials)
      raise ArgumentError unless credentials.kind_of? Hash
      raise KeyError if credentials.empty?

      # Please provide this four exact parameters
      raise ArgumentError if credentials.keys.count != 4 and credentials.keys & [:app_key, :app_secret, :access_token, :access_token_secret] != [:app_key, :app_secret, :access_token, :access_token_secret]
    
      @consumer = OAuth::Consumer.new(credentials[:app_key], credentials[:app_secret], { :site => HOST})
      @access_token = OAuth::AccessToken.new(@consumer, credentials[:access_token], credentials[:access_token_secret])
    end

  end

end
