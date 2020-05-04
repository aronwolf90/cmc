# frozen_string_literal: true

module Api::V1
  module Issues
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          optional(:attributes).schema do
            optional(:title).filled
          end
          optional(:relationships).schema do
            optional(:project).schema(OptionalBelongsToSchema)
            optional(:"board-list").schema(RequiredBelongsToSchema)
          end
        end
      end
    end
  end
end
