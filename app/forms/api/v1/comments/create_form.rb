# frozen_string_literal: true

module Api::V1
  module Comments
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          required(:attributes).schema do
            required(:content).filled
          end
          required(:relationships).schema do
            required(:user).filled.schema(RequiredBelongsToSchema)
            required(:issue).filled.schema(RequiredBelongsToSchema)
          end
        end
      end
    end
  end
end
