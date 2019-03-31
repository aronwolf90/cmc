# frozen_string_literal: true

module Administration::Users
  class NewOperation < BaseOperation
    @form = CreateForm
    include MvcStandardNewOperationConcern
  end
end
