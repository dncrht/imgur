module Imgur
  class Image < Base

    IMAGE_URL = 'http://i.imgur.com/'
    IMAGE_EXTENSION = 'jpg' # jpg is the default extension for every Imgur image

    # Provides the download URL in case you know a valid imgur hash and don't want to make a network trip with .find
    # Just in case you don't need the full Imgur::Image object
    def url(size = nil)
      size = case size
             when :small_square
               's'
             when :large_thumbnail
               'l'
             end

      splitted_link = link.split('.')

      splitted_link.insert(splitted_link.size - 1, size).join
    end
  end
end
