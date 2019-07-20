# frozen_string_literal: true

module Api::V1
  module Events
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          required(:attributes).schema do
            optional(:title).filled
            optional(:"start-time").filled
          end
        end
      end
    end
  end
end
