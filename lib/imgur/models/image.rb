module Imgur

  # Class definition for an Image
  class Image
  
    # Create image from hash
    def initialize(hsh = {})
      hsh.each do |k, v|
        singleton_class.class_eval do
          attr_accessor k
        end
        send("#{k}=", v)
      end
    end
  end

end
