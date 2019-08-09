# frozen_string_literal: true

module Api::V1
  module ContactAvatars
    class CreateForm < ApiForm
      @form = Dry::Validation.Schema do
        required(:data).schema do
          required(:file).filled
        end
      end
    end
  end
end
