# frozen_string_literal: true

module Administration::Users
  class UpdateOperation < BaseOperation
    @form = UpdateForm
    include MvcStandardUpdateOperationConcern
  end
end
