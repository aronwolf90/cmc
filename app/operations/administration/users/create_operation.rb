# frozen_string_literal: true

module Administration::Users
  class CreateOperation < BaseOperation
    @form = CreateForm
    include MvcStandardCreateOperationConcern
  end
end
