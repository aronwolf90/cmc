# frozen_string_literal: true

module Api::V1
  module Labels
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          required(:attributes).schema do
            required(:name).filled
            required(:color).filled
          end
        end
      end
    end
  end
end
