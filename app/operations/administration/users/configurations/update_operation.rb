# frozen_string_literal: true

module Administration
  module Users
    module Configurations
      class UpdateOperation < AdministrationOperation
        @form = ConfigurationForm
        @model_step = ParentAsModelStep.new(model: User, key: :user_id)
        include MvcStandardUpdateOperationConcern
      end
    end
  end
end
