# frozen_string_literal: true

module Api::V1
  module AttendanceEvents
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:data).schema do
          required(:attributes).schema do
            required(:"from-day").filled
            optional(:"to-day").maybe
            optional(:"from-time").maybe
            optional(:"to-time").maybe
            optional(:description).maybe
          end
          required(:relationships).schema do
            required(:user).schema(RequiredBelongsToSchema)
          end
        end
      end
    end
  end
end
