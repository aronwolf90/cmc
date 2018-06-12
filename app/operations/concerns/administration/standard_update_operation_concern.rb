# frozen_string_literal: true

module Administration
  module StandardUpdateOperationConcern
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
        success UpdateMutationStep.new(mutation: @mutation)
      else
        success base::Contract::Persist()
      end
    end
  end
end
