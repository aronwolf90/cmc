# frozen_string_literal: true

module Administration
  module StandardCreateOperationConcern
    extend ActiveSupport::Concern

    included do |base|
      form = @form
      default_value_step = @default_value_step

      base.const_set("Present", Class.new(Trailblazer::Operation) do
        success self::Model(form.model_options.first, :new)
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
end
