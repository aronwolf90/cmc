module Api
  module V1
    class BaseForm
      include ActiveModel::Model

      attr_reader :relationships, :param_attributes, :id

      class << self
        def attributes(*array)
          attr_accessor(*array)

          define_method :attributes do
            array
          end
        end

        def clazz(constant)
          define_method :clazz do
            constant
          end
        end

        def associations(array)
          define_method :associations do
            array
          end
        end
      end

      def initialize(params)
        @relationships = params[:relationships]
        @param_attributes = params[:attributes]
        @id = params[:id]

        super(
          model.attributes
               .slice(*attributes.map(&:to_s))
               .merge(params[:attributes])
        )
      end

      def model
        if @model.nil?
          @model = clazz.find(id)
          @model.assign_attributes(param_attributes)
        end

        @model
      end

      def save
        return false if invalid?

        model.save!
        save_relationships!
      end

      protected

      def save_relationships!
        relationships.each do |type, data|
          model.send(type + '=', new_relations(type, data))
          raise 'invalid' if model.invalid?
        end
      end

      def new_relations(type, data)
        data[:data].map { |entry| entry[:id] }.map do |id|
          type.singularize.capitalize.constantize.find(id)
        end
      end
    end
  end
end
