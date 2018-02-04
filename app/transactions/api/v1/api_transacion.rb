module Api
  module V1
    class ApiTransacion
      include Dry::Transaction

      def self.call(*args)
        new.call(*args)
      end
    end
  end
end
