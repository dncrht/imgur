module Imgurapi
  class Image < Base

    IMGUR_HOST = 'i.imgur.com'
    IMAGE_EXTENSION = 'jpg' # jpg is the default extension for every Imgur image

    def link(use_ssl = false)
      protocol = if use_ssl
                   'https://'
                 else
                   'http://'
                 end

      "#{protocol}#{IMGUR_HOST}/#{id}.#{IMAGE_EXTENSION}"
    end

    # Provides the download URL in case you know a valid imgur hash and don't want to make a network trip with .find
    # Just in case you don't need the full Imgurapi::Image object
    def url(size: nil, use_ssl: false)
      size = case size
             when :small_square, :small, :s
               's'
             when :large_thumbnail, :large, :l
               'l'
             else
               ''
             end

      splitted_link = link(use_ssl).split('.')
      splitted_link[splitted_link.size - 2] << size
      splitted_link.join '.'
    end
  end
end
