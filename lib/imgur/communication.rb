module Imgur
  Communication = Struct.new(:session) do

    API_VERSION = 3

    # RESTful network call
    def call(method, endpoint, params = nil)
      request do
        session.connection.send method, "/#{API_VERSION}/#{endpoint}.json", params
      end
    end

    private

    # Processes RESTful response according the status code
    def request(&block)
      3.times do
        response = yield

        case response.status
        when 200, 404
          return parse_message response.body
        when 401, 500
          error_message = parse_message response.body
          raise "Unauthorized: #{error_message['error']['message']}"
        when 403
          get_new_and_reset_token

          request &block # and retry the request
        else
          puts response.body
          raise "Response code #{response.status} not recognized"
        end
      end

      raise "Retried 3 times but could not get an access_token"
    end

    def get_new_and_reset_token
      access_token = parse_message(
        session.connection.post(
          '/oauth2/token',
          session.params.merge(grant_type: 'refresh_token')
        ).body
      )['access_token']

      session.access_token = access_token
    end

    # Parses the response as JSON and returns the resulting hash
    def parse_message(message)
      begin
        JSON.parse(message)
      rescue => e
        raise "Failed trying to parse response: #{e}"
      end
    end
  end
end
