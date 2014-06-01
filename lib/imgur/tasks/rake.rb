module Imgur

  module Rake
    extend self

    def authorize(client_id, client_secret)
      connection = Faraday.new(HOST)

      puts "\nVisit this URL: #{HOST}/oauth2/authorize?client_id=#{client_id}&response_type=pin"
      print 'And after you approved the authorization please enter your verification code: '

      pin = STDIN.gets.strip

      begin
        response = connection.post '/oauth2/token', pin: pin, client_id: client_id, client_secret: client_secret, grant_type: 'pin'

        response.body # to json
        #a response: "{\"access_token\":\"99c8dbddca8209e681342b93df90c9db5025f356\",\"expires_in\":3600,\"token_type\":\"bearer\",\"scope\":null,\"refresh_token\":\"48210115d8aeb327e9ce3c6bb561985ab2bec9e1\",\"account_username\":\"robotyard\"}"
      rescue
        puts "Authorization failed.\nPlease try again."
        exit
      end

      puts <<-MESSAGE

Authorization was successful. Here you go:

access_token: #{access_token.token}
access_token_secret: #{access_token.secret}

        MESSAGE
    end

  end

end
