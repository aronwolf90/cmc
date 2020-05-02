# frozen_string_literal: true

module Api::V1
  module Projects
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          required(:attributes).schema do
            required(:name).filled
          end
          optional(:relationships).schema do
            optional(:contact).schema do
              optional(:data).schema do
                optional(:attributes).schema do
                  required(:name).filled
                end
              end
            end
          end
        end
      end
    end
  end
end
