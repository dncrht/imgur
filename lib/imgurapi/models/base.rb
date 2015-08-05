module Imgurapi
  class Base
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
