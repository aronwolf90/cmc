# frozen_string_literal: true

module Api::V1
  module Documents
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          optional(:attributes).schema do
            optional(:name).filled
            optional(:"document-file-id").filled
          end
          optional(:relationships).schema do
            optional(:folder).filled.schema(RequiredBelongsToSchema)
          end
        end
      end
    end
  end
end
