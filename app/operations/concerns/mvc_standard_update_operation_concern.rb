# frozen_string_literal: true

module MvcStandardUpdateOperationConcern
  extend ActiveSupport::Concern

  included do |base|
    form = @form
    model_step = @model_step || self::Model(form.model_options.first, :find)
    policy = @policy || "#{form.model_options.first}Policy".constantize
    mutation = @mutation || StandardUpdateMutation

    base.const_set("Present", Class.new(Trailblazer::Operation) do
      success model_step
      step self::Policy::Pundit(policy, :update?) if policy
      step self::Contract::Build(constant: form)
    end)

    step base::Nested(base::Present)
    step MvcInjectStep.new(:current_user)
    step base::Contract::Validate(key: :data)
    success MvcUpdateMutationStep
  end
end
