# frozen_string_literal: true

module Api::V1
  module Folders
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          required(:attributes).schema do
            required(:name).filled(:present?)
          end
        end
      end
    end
  end
end
