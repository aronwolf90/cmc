# frozen_string_literal: true

module Api::V1
  module Users
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          optional(:relationships).schema do
            optional(:'selected-project').schema(OptionalBelongsToSchema)
          end
        end
      end
    end
  end
end
