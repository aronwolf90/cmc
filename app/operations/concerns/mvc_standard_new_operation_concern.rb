# frozen_string_literal: true

module MvcStandardNewOperationConcern
  extend ActiveSupport::Concern

  included do |base|
    @policy = "#{@form.model_options.first}Policy".constantize
    @model_class = @form.model_options.first

    step base::Model(@model_class, :new)
    step base::Contract::Build(constant: @form)
    step base::Policy::Pundit(@policy, :create?)
  end
end
