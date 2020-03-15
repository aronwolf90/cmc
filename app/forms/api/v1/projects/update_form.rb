# frozen_string_literal: true

module Api::V1
  module Projects
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          optional(:attributes).schema do
            optional(:name).filled
          end
        end
      end
    end
  end
end
