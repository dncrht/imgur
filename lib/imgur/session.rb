module Imgur

  class Session
    include API
    include Communication

    # Creates the session instance that handles all the API calls to Imgur
    # access_token is optional
    def initialize(options)
      required_arguments = %i(client_id client_secret refresh_token)
      raise ArgumentError if required_arguments & options.keys != required_arguments

      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
      @access_token = options[:access_token]
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
