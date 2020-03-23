# frozen_string_literal: true

module Api::V1
  module ProjectBoardLists
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        optional(:data).schema do
          optional(:attributes).schema do
            optional(:name).filled
            optional(:'ordinal-number').filled
          end
        end
      end
    end
  end
end
