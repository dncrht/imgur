module Imgur

  module API
  
    # Uploads a file to imgur and returns an Image
    def upload(local_file)
      if local_file.kind_of? String
        file = File.open(local_file, 'rb')
      elsif local_file.respond_to? :read
        file = local_file
      else
        raise 'Must provide a File or file path'
      end
      
      hsh = process_response(post('/images', {:image => Base64.encode64(file.read)}))
      hsh = hsh.symbolize_keys_recursively
      
      compose_image hsh
    end
    
    # Queries imgur for an image
    def find(id)
      raise 'Please provide a valid image identificator' if id.nil? or !id.kind_of? String or id == '' or !!(id =~ /[^\w]/)
      
      hsh = process_response(get("/images/#{id}"))
      hsh = hsh.symbolize_keys_recursively

      compose_image hsh
    end
    
    # Removes an image from imgur
    def destroy(id)
      if id.kind_of? Imgur::Image
        id = id.hash
      end

      raise 'Please provide a valid image identificator' if id.nil? or !id.kind_of? String or id == '' or !!(id =~ /[^\w]/)
      
      hsh = process_response(delete("/images/#{id}"))
    
      hsh[hsh.keys.first]['message'] == 'Success' #returns true or false
    end

    # Return a hash with account info
    def account
      process_response(get)['account']
    end

    # Number of images stored
    def images_count
      process_response(get('/images_count'))["images_count"]["count"]
    end
    
  end

end
