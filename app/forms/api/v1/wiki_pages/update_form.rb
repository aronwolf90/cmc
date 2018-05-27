# frozen_string_literal: true

module Api::V1
  module WikiPages
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          optional(:attributes).schema do
            optional(:title).filled
            optional(:content).filled
          end
        end
      end
    end
  end
end
