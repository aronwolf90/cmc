# frozen_string_literal: true

module Administration
  module StandardUpdateOperationConcern
    extend ActiveSupport::Concern

    included do |base|
      form = @form
      base.const_set("Present", Class.new(Trailblazer::Operation) do
        step base::Model(form.model_options.first, :find)
        step base::Contract::Build(constant: form)
      end)

      step base::Nested(base::Present)
      step base::Contract::Validate(key: :data)
      step base::Contract::Persist()
    end
  end
end
