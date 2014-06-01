module Imgur

  class Session
    include API
    include Communication

    # Creates the session instance that handles all the API calls to Imgur
    def initialize(options)
      raise ArgumentError if options.keys.sort != [:client_id, :client_secret, :refresh_token]

      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
      @access_token = "we don't know yet"
      @refresh_token = options[:refresh_token]
    end

    private

    def connection
      @connection ||= Faraday.new(
        HOST,
        headers: {'Authorization' => 'Bearer ' << @access_token}
      )
    end

  end

end
