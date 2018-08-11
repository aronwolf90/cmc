# frozen_string_literal: true

module Administration
  module BoardLists
    class CreateOperation < AdministrationOperation
      @form = BoardListForm
      include MvcStandardCreateOperationConcern
    end
  end
end
