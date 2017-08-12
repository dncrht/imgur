require 'imgurapi/session'
require 'faraday'

module Imgurapi

  module Rake
    extend self

    AUTHORIZE_ENDPOINT = '/oauth2/authorize'
    TOKEN_ENDPOINT = '/oauth2/token'

    def authorize(client_id, client_secret)
      puts "\nVisit this URL: #{Imgurapi::Session::HOST}#{AUTHORIZE_ENDPOINT}?client_id=#{client_id}&response_type=pin"
      print 'And after you approved the authorization please enter your verification code: '

      pin = STDIN.gets.strip

      begin
        response = Faraday.new(Imgurapi::Session::HOST).post(TOKEN_ENDPOINT, pin: pin, client_id: client_id, client_secret: client_secret, grant_type: 'pin')

        raise "HTTP #{response.status}" if response.status != 200
        credentials = JSON.parse response.body
      rescue => e
        puts "Authorization failed: #{e.message}\nPlease try again."
        exit
      end

      puts <<-MESSAGE

Authorization was successful. These are your credentials to initialize the library:

JSON format, for credentials.json:

{
"client_id": "#{client_id}",
"client_secret": "#{client_secret}",
"access_token": "#{credentials['access_token']}",
"refresh_token": "#{credentials['refresh_token']}"
}

YAML format, for imgur.yml:

client_id: #{client_id}
client_secret: #{client_secret}
access_token: #{credentials['access_token']}
refresh_token: #{credentials['refresh_token']}

MESSAGE
    end
  end
end
