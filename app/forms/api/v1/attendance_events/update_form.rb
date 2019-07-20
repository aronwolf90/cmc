# frozen_string_literal: true

module Api::V1
  module AttendanceEvents
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          optional(:attributes).schema do
            optional(:"from-day").filled
            optional(:"to-day").filled
            optional(:"from-time").filled
            optional(:"to-time").filled
            optional(:description).filled
          end
          optional(:relationships).schema do
            optional(:user).schema(RequiredBelongsToSchema)
          end
        end
      end
    end
  end
end
