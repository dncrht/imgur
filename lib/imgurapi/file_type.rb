module Imgurapi
  class FileType

    GIF = /^GIF8/
    PNG = Regexp.new("^\x89PNG".force_encoding('binary'))
    JPG = Regexp.new("^\xff\xd8\xff\xe0\x00\x10JFIF".force_encoding('binary'))
    JPG2 = Regexp.new("^\xff\xd8\xff\xe1(.*){2}Exif".force_encoding('binary'))

    def initialize(path)
      @path = path
    end

    def mime_type
      case IO.read(@path, 10)
      when GIF
        'image/gif'
      when PNG
        'image/png'
      when JPG
        'image/jpeg'
      when JPG2
        'image/jpeg'
      end
    end

    def image?
      !!mime_type
    end

    def url?
      !!(@path =~ %r(^(http://|https://|ftp://)))
    end
  end
end
