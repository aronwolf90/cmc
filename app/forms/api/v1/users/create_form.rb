# frozen_string_literal: true

module Api::V1
  module Users
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end
        required(:data).schema do
          required(:attributes).schema do
            required(:firstname).filled
            required(:lastname).filled
            required(:email).filled
            required(:type).filled
          end
        end
      end
    end
  end
end
