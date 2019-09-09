# frozen_string_literal: true

module Api::V1
  module DocumentFiles
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        required(:data).schema do
          required(:file).filled
          optional(:not_finished).filled
        end
      end
    end
  end
end
