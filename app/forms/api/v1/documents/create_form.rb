# frozen_string_literal: true

module Api::V1
  module Documents
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          required(:attributes).schema do
            required(:name).filled(:present?)
            required(:"document-file-id").filled(:present?)
          end
          required(:relationships).schema do
            required(:folder).schema(RequiredBelongsToSchema)
          end
        end
      end
    end
  end
end
