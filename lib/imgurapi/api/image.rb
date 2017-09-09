module Imgurapi
  module Api
    class Image < Base

      # https://api.imgur.com/endpoints/image#image
      def image(id)
        raise 'Please provide a valid image identificator' if id.nil? || !id.is_a?(String) || id == '' || !!(id =~ /[^\w]/)

        Imgurapi::Image.new communication.call(:get, "image/#{id}")
      end

      # https://api.imgur.com/endpoints/image#image-upload
      def image_upload(local_file)
        raise 'File must be an image' unless FileType.new(local_file).image?
        if local_file.is_a?(String)
          file = File.open(local_file, 'rb')
        elsif local_file.respond_to? :read
          file = local_file
        else
          raise 'Must provide a File or file path'
        end

        Imgurapi::Image.new communication.call(:post, 'image', image: Base64.encode64(file.read))
      end

      # https://api.imgur.com/endpoints/image#image-delete
      def image_delete(id)
        if id.kind_of? Imgurapi::Image
          id = id.id
        end

        raise 'Please provide a valid image identificator' if id.nil? || !id.is_a?(String) || id == '' || !!(id =~ /[^\w]/)

        communication.call(:delete, "image/#{id}")
      end
    end
  end
end
