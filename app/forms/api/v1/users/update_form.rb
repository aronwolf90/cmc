# frozen_string_literal: true

module Api::V1
  module Users
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          optional(:relationships).schema do
            optional(:'selected-project').schema do
              optional(:data).maybe(:record_exists?) do
                hash? do
                  required(:id).filled
                  required(:type).filled
                end
              end
            end
          end
        end
      end
    end
  end
end
