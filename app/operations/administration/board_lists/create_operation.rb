# frozen_string_literal: true

module Administration
  module BoardLists
    class CreateOperation < AdministrationOperation
      include MvcStandardCreateOperationConcern
    end
  end
end
