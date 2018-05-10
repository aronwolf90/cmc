# frozen_string_literal: true


module Api::V1
  module Comments
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          required(:attributes).schema do
            required(:content).filled
          end
          required(:relationships).schema do
            required(:user).filled.schema do
              required(:data).filled(:record_exists?).schema do
                required(:id).filled
                required(:type).filled
              end
            end
            required(:issue).filled.schema do
              required(:data).filled(:record_exists?).schema do
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
