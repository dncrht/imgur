module Imgur
  module Api
    class Image < Base

      # https://api.imgur.com/endpoints/image#image
      def image(id)
        raise 'Please provide a valid image identificator' if id.nil? or !id.kind_of? String or id == '' or !!(id =~ /[^\w]/)

        Imgur::Image.new communication.call(:get, "image/#{id}")
      end

      # https://api.imgur.com/endpoints/image#image-upload
      def image_upload(local_file)
        if local_file.kind_of? String
          file = File.open(local_file, 'rb')
        elsif local_file.respond_to? :read
          file = local_file
        else
          raise 'Must provide a File or file path'
        end

        Imgur::Image.new communication.call(:post, 'image', image: Base64.encode64(file.read))
      end

      # https://api.imgur.com/endpoints/image#image-delete
      def image_delete(id)
        if id.kind_of? Imgur::Image
          id = id.id
        end

        raise 'Please provide a valid image identificator' if id.nil? or !id.kind_of? String or id == '' or !!(id =~ /[^\w]/)

        communication.call(:delete, "image/#{id}")
      end
    end
  end
end
