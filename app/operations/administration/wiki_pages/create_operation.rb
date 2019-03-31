# frozen_string_literal: true

module Administration
  module WikiPages
    class CreateOperation < AdministrationOperation
      include MvcStandardCreateOperationConcern
    end
  end
end
