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

      Image.new communication.call(:post, 'image', image: Base64.encode64(file.read))['data']
    end

    # Queries imgur for an image
    def find(id)
      raise 'Please provide a valid image identificator' if id.nil? or !id.kind_of? String or id == '' or !!(id =~ /[^\w]/)

      Image.new communication.call(:get, "image/#{id}")
    end

    # Removes an image from imgur
    def destroy(id)
      if id.kind_of? Imgur::Image
        id = id.id
      end

      raise 'Please provide a valid image identificator' if id.nil? or !id.kind_of? String or id == '' or !!(id =~ /[^\w]/)

      communication.call(:delete, "image/#{id}")['data']
    end

    private

    def communication
      Communication.new(self)
    end
  end
end
