# frozen_string_literal: true

module Api::V1
  module Folders
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end
      end
    end
  end
end
