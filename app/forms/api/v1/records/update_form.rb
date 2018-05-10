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
            optional(:user).schema do
              required(:data).filled(:record_exists?).schema do
                required(:id).filled
                required(:type).filled
              end
            end
            optional(:issue).schema do
              required(:data).filled(:record_exists?).schema do
                required(:id).filled(:numeric_format?)
                required(:type).filled
              end
            end
          end
        end
      end
    end
  end
end
