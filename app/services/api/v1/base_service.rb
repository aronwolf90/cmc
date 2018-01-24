module Api
  module V1
    class BaseService
      attr_reader :model, :params

      def initialize(model, params:)
        @model = model
        @params = params
      end

      def param_attributes
        params[:data][:attributes]
      end

      def relationships
        params[:data][:relationships].to_h
      end

      def perform
        ActiveRecord::Base.transaction do
          save_model! if param_attributes.present?
          save_relationships!
        end
      end

      protected

      def save_model!
        model.assign_attributes(param_attributes)
        model.save!
      end

      def save_relationships!
        relationships.each do |type, data|
          if type == type.singularize
            model.update!(type => type.capitalize.constantize.find(data[:data][:id]))
          else
            model.update!(type => new_relations(type, data))
          end
          raise 'invalid' if model.invalid?
        end
      end

      private

      def new_relations(type, data)
        data[:data].map { |entry| entry[:id] }.map do |id|
          type.singularize.capitalize.constantize.find(id)
        end
      end
    end
  end
end
