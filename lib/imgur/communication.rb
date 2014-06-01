module Imgur

  module Communication

    API_VERSION = 3

    private

    # RESTful GET call
    def get(method = '')
      connection.get("/#{API_VERSION}/account/me/#{method}.json")
    end

    # RESTful POST call
    def post(method, params)
      connection.post("/#{API_VERSION}/account/me/#{method}.json", params)
    end

    # RESTful DELETE call
    def delete(method)
      connection.delete("/#{API_VERSION}/account/me/#{method}.json")
    end

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
          reset_access_token

          request &block # and retry the request
        else
          raise "Response code #{response.status} not recognized"
        end
      end

      raise "Retried 3 times but could not get an access_token"
    end

    # Request a new access token if expired
    def reset_access_token
      @access_token = parse_message(
        connection.post(
          '/oauth2/token',
          refresh_token: @refresh_token,
          client_id:     @client_id,
          client_secret: @client_secret,
          grant_type:    'refresh_token'
        ).body
      )['access_token']

      # Force new connection headers
      @connection = nil
    end

    # Parses the response as JSON and returns the resulting hash
    def parse_message(message)
      begin
        JSON.parse(message)
      rescue => e
        raise "Failed trying to parse response: #{e}"
      end
    end

    # Compose an object that represents an image, shifting the links into a Image.links attribute
    def compose_image(hsh)
      return nil if !hsh.include? :images or !hsh[:images].include? :image or !hsh[:images].include? :links

      links = Links.new(hsh[:images][:links])

      hsh[:images][:image][:links] = links

      Image.new(hsh[:images][:image])
    end

  end

end
