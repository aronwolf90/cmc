# frozen_string_literal: true

module Api::V1
  module Users
    module Configuration
      class UpdateForm < ApiForm
        @form = Dry::Validation.Schema do
          configure do
            predicates(ApiPredicates)
          end

          types = Dry::Types["strict.string"].enum("Admin", "Employee", "Customer")

          required(:data).schema do
            optional(:attributes).schema do
              optional(:type).filled(types)
            end
          end
        end
      end
    end
  end
end
