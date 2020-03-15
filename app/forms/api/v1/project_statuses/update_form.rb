# frozen_string_literal: true

module Api::V1
  module ProjectStatuses
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          required(:attributes).schema do
            optional(:name).filled
          end
        end
      end
    end
  end
end
