# frozen_string_literal: true

module Api::V1
  module Issues
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          optional(:attributes).schema do
            optional(:title).filled
            optional(:description).filled
          end
          optional(:relationships).schema do
            optional(:user).filled(:record_exists?).schema do
              required(:data).schema do
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
