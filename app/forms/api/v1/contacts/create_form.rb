# frozen_string_literal: true

module Api::V1
  module Contacts
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end
      end
    end
  end
end