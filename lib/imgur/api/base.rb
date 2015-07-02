module Imgur
  module Api
    Base = Struct.new(:session) do

      def communication
        Communication.new(session)
      end

    end
  end
end
