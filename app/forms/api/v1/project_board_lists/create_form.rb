# frozen_string_literal: true

module Api::V1
  module ProjectBoardLists
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          required(:attributes).schema do
            required(:name).filled
          end
          required(:relationships).schema do
            required(:'project-status').schema(RequiredBelongsToSchema)
          end
        end
      end
    end
  end
end
