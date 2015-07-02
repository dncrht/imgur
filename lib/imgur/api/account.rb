module Imgur
  module Api
    class Account < Base

      # https://api.imgur.com/endpoints/account#account
      def account
        Account.new communication.call(:get, 'account/me')['data']
      end

      # https://api.imgur.com/endpoints/account#images
      def images(page = 0)
        communication.call(:get, "account/me/images/#{page}")['data'].map do |image|
          Image.new image
        end
      end

      # https://api.imgur.com/endpoints/account#image-count
      def image_count
        communication.call(:get, 'account/me/images/count')['data']
      end
    end
  end
end
