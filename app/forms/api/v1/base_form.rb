module Api
  module V1
    class BaseForm
      include ActiveModel::Model

      attr_reader :relationships, :param_attributes, :model

      class << self
        def attributes(*array)
          attr_accessor(*array)

          define_method :attributes do
            array
          end
        end

        def associations(array)
          define_method :associations do
            array
          end
        end
      end

      def initialize(model, params:)
        @relationships = params[:data][:relationships]
        @param_attributes = params[:data][:attributes] || {}
        @model = model

        super(param_attributes)
      end

      def params_contains?(field)
        param_attributes.key?(field)
      end
    end
  end
end
