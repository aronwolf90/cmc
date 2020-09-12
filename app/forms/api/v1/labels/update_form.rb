# frozen_string_literal: true

module Api::V1
  module Labels
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          optional(:attributes).schema do
            optional(:name).filled
            optional(:color).filled
          end
        end
      end
    end
  end
end
