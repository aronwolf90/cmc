# frozen_string_literal: true

module Api::V1
  module Records
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          optional(:attributes).schema do
            optional(:'start-time').filled
            optional(:complexity).maybe(:numeric_format?)
          end
          optional(:relationships).schema do
            optional(:user).schema(RequiredBelongsToSchema)
            optional(:issue).schema(RequiredBelongsToSchema)
          end
        end
      end
    end
  end
end
