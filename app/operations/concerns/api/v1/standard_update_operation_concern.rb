# frozen_string_literal: true

module Api::V1
  module StandardUpdateOperationConcern
    extend ActiveSupport::Concern

    included do
      step ValidateStep.new(form: @form)
      success DeserializeStep.new(deserializer: @deserializer)
      success UpdateStep.new
    end
  end
end
