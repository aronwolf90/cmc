# frozen_string_literal: true

module Administration
  module BoardLists
    class UpdateOperation < AdministrationOperation
      @form = BoardListForm
      include MvcStandardUpdateOperationConcern
    end
  end
end
