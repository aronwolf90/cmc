# frozen_string_literal: true

module Api::V1
  module Events
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          required(:attributes).schema do
            required(:title).filled
            required(:"start-time").filled
          end
        end
      end
    end
  end
end
