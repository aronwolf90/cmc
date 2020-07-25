# frozen_string_literal: true

module Api::V1
  module StandardCreateOperationConcern
    extend ActiveSupport::Concern

    included do
      success self::Model(@model, :new)
      step ValidateStep.new(form: @form)
      success DeserializeStep.new(deserializer: @deserializer)
      step self::Policy::Pundit(@policy, :create?) if @policy
      unless @no_mutation_step
        success CreateMutationStep
      end
    end
  end
end
