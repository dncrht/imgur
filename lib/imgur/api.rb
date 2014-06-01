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

      hsh = request { post('/images', {:image => Base64.encode64(file.read)}) }
      hsh = hsh.symbolize_keys_recursively

      compose_image hsh
    end

    # Queries imgur for an image
    def find(id)
      raise 'Please provide a valid image identificator' if id.nil? or !id.kind_of? String or id == '' or !!(id =~ /[^\w]/)

      hsh = request { get("/images/#{id}") }
      hsh = hsh.symbolize_keys_recursively

      compose_image hsh
    end

    # Removes an image from imgur
    def destroy(id)
      if id.kind_of? Imgur::Image
        id = id.hash
      end

      raise 'Please provide a valid image identificator' if id.nil? or !id.kind_of? String or id == '' or !!(id =~ /[^\w]/)

      hsh = request { delete("/images/#{id}") }

      hsh[hsh.keys.first]['message'] == 'Success' #returns true or false
    end

    # Return a hash with account info
    def account
      Account.new request { get }['data']
    end

    # Number of images stored
    def images_count
      request { get('images/count') }['data']
    end

    # Provides the download URL in case you know a valid imgur hash and don't want to make a network trip with .find
    # Just in case you don't need the full Imgur::Image object
    def url(id = nil, size = nil)
      return '' unless id.kind_of? String

      case size
      when :small_square
        size = 's'
      when :large_thumbnail
        size = 'l'
      else
        size = ''
      end

      "#{IMAGE_URL}#{id}#{size}.#{IMAGE_EXTENSION}"
    end

  end

end
