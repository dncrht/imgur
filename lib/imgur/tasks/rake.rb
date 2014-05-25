module Imgur

  module Rake
    extend self

    def authorize(app_key, app_secret)
      consumer = OAuth::Consumer.new(app_key, app_secret, { :site => HOST })

      request_token = consumer.get_request_token

      puts "\nVisit this URL: #{request_token.authorize_url}"
      print 'And after you approved the authorization please enter your verification code: '

      verifier = STDIN.gets.strip

      begin
        access_token = request_token.get_access_token(:oauth_verifier => verifier)
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
