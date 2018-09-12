# frozen_string_literal: true

module Api::V1
  module StandardUpdateOperationConcern
    extend ActiveSupport::Concern

    included do
      success self::Model(@model, :find)
      step ValidateStep.new(form: @form)
      success DeserializeStep.new(deserializer: @deserializer)
      step self::Policy::Pundit(@policy, :update?) if @policy
      success UpdateMutationStep
    end
  end
end
