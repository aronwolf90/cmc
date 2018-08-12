# frozen_string_literal: true

module MvcStandardUpdateOperationConcern
  extend ActiveSupport::Concern

  included do |base|
    form = @form
    model_step = @model_step
    base.const_set("Present", Class.new(Trailblazer::Operation) do
      if model_step
        success model_step
      else
        step self::Model(form.model_options.first, :find)
      end
      step self::Contract::Build(constant: form)
    end)

    step base::Nested(base::Present)
    step base::Contract::Validate(key: :data)
    if @mutation.present?
      success MvcUpdateMutationStep.new(mutation: @mutation)
    else
      success base::Contract::Persist()
    end
  end
end
