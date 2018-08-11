# frozen_string_literal: true

module MvcStandardCreateOperationConcern
  extend ActiveSupport::Concern

  included do |base|
    form = @form
    model_step = @model_step
    default_value_step = @default_value_step

    base.const_set("Present", Class.new(Trailblazer::Operation) do
      if model_step
        success model_step
      else
        success self::Model(form.model_options.first, :new)
      end

      if default_value_step.present?
        success default_value_step
      end
      success self::Contract::Build(constant: form)
    end)

    step base::Nested(base::Present)
    step base::Contract::Validate(key: :data)
    if @mutation.present?
      success CreateMutationStep.new(mutation: @mutation)
    else
      success base::Contract::Persist()
    end
  end
end
