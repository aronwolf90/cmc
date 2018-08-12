# frozen_string_literal: true

module MvcStandardUpdateOperationConcern
  extend ActiveSupport::Concern

  included do |base|
    form = @form
    base.const_set("Present", Class.new(Trailblazer::Operation) do
      step self::Model(form.model_options.first, :find)
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
