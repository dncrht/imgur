module Imgur
  
  class Session
    include API
    include Communication
    
    # Creates the session instance that handles all the API calls to Imgur
    def initialize(app_key, app_secret, access_token_key, access_token_secret)
      @consumer = OAuth::Consumer.new(app_key, app_secret, { :site => HOST})
      @access_token = OAuth::AccessToken.new(@consumer, access_token_key, access_token_secret)
    end

  end

end
