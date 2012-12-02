module Imgur

  module Communication
  
    private
    
    # RESTful GET call
    def get(method = '')
      @access_token.get("/2/account#{method}.json")
    end

    # RESTful POST call
    def post(method, params)
      @access_token.post("/2/account#{method}.json", params)
    end

    # RESTful DELETE call
    def delete(method)
      @access_token.delete("/2/account#{method}.json")
    end

    # Processes RESTful response according the status code
    def process_response(response)
      case response.code.to_i
      when 200, 404
        parse_message response.body
      when 401, 500
        error_message = parse_message response.body
        raise "Unauthorized: #{error_message['error']['message']}"
      else
        raise "Response code #{response.code} not recognized"
      end
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
