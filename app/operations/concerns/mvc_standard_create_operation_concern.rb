# frozen_string_literal: true

module MvcStandardCreateOperationConcern
  extend ActiveSupport::Concern

  included do |base|
    form = @form
    model_step = @model_step || self::Model(form.model_options.first, :new)
    policy = "#{form.model_options.first}Policy"

    base.const_set("Present", Class.new(Trailblazer::Operation) do
      success model_step
      step self::Policy::Pundit(policy.constantize, :create?) rescue NameError
      success self::Contract::Build(constant: form)
    end)

    success base::Nested(base::Present)
    success MvcInjectStep.new(:current_user)
    step base::Contract::Validate(key: :data)
    success MvcCreateMutationStep
  end
end
