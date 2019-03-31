# frozen_string_literal: true

module MvcStandardCreateOperationConcern
  extend ActiveSupport::Concern

  included do |base|
    success base::Nested(base.parent::NewOperation)
    success MvcInjectStep.new(:current_user)
    step base::Contract::Validate(key: :data)
    success MvcCreateMutationStep
  end
end
