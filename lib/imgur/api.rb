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

      Image.new request { post 'image', image: Base64.encode64(file.read) }['data']
    end

    # Queries imgur for an image
    def find(id)
      raise 'Please provide a valid image identificator' if id.nil? or !id.kind_of? String or id == '' or !!(id =~ /[^\w]/)

      Image.new request { get "image/#{id}" }
    end

    # Removes an image from imgur
    def destroy(id)
      if id.kind_of? Imgur::Image
        id = id.id
      end

      raise 'Please provide a valid image identificator' if id.nil? or !id.kind_of? String or id == '' or !!(id =~ /[^\w]/)

      hsh = request { delete "image/#{id}" }['data']
    end

    def images(page = 0)
      request { get "account/me/images/#{page}" }['data'].map do |image|
        Image.new image
      end
    end

    # Return a hash with account info
    def account
      Account.new request { get 'account/me' }['data']
    end

    # Number of images stored
    def images_count
      request { get 'account/me/images/count' }['data']
    end
  end
end
