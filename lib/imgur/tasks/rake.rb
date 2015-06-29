module Imgur

  module Rake
    extend self

    AUTHORIZE_ENDPOINT = '/oauth2/authorize'
    TOKEN_ENDPOINT = '/oauth2/token'

    def authorize(client_id, client_secret)
      connection = Faraday.new(HOST)

      puts "\nVisit this URL: #{HOST}#{AUTHORIZE_ENDPOINT}?client_id=#{client_id}&response_type=pin"
      print 'And after you approved the authorization please enter your verification code: '

      pin = STDIN.gets.strip

      begin
        response = JSON.parse connection.post(TOKEN_ENDPOINT, pin: pin, client_id: client_id, client_secret: client_secret, grant_type: 'pin').body
      rescue
        puts "Authorization failed.\nPlease try again."
        exit
      end

      puts <<-MESSAGE

Authorization was successful. Use these credentials to initialize the library:

access_token: #{response['access_token']}
refresh_secret: #{response['refresh_token']}

        MESSAGE
    end

  end

end
