# frozen_string_literal: true

module Api::V1
  module StandardCreateOperationConcern
    extend ActiveSupport::Concern

    included do
      step ValidateStep.new(form: @form)
      success DeserializeStep.new(deserializer: @deserializer)
      step self::Policy::Pundit(@policy, :create?) if @policy
      if @mutation
        success CreateMutationStep.new(mutation: @mutation)
      else
        success CreateStep.new(model_class: @model)
      end
    end
  end
end
