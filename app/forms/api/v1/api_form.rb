# frozen_string_literal: true

module Api
  module V1
    class ApiForm
      def self.call(params)
        @form.call(params)
      end

      RequiredBelongsToSchema = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).filled(:record_exists?).schema do
          required(:id).filled
          required(:type).filled
        end
      end

      OptionalBelongsToSchema = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        optional(:data).maybe(:record_exists?).schema do
          required(:id).filled
          required(:type).filled
        end
      end

      RequiredMasManySchema = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).each do
          schema do
            required(:id).filled
            required(:type).filled
          end
        end
      end
    end
  end
end
