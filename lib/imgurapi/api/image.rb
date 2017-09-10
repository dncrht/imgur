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
        file_type = FileType.new(local_file)

        image = if file_type.url?
                  local_file
                else
                  raise 'File must be an image' unless file_type.image?

                  file = local_file.respond_to?(:read) ? local_file : File.open(local_file, 'rb')

                  Base64.encode64(file.read)
                end

        Imgurapi::Image.new communication.call(:post, 'image', image: image)
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
