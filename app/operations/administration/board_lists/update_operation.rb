# frozen_string_literal: true

module Administration
  module BoardLists
    class UpdateOperation < AdministrationOperation
      @form = BoardListForm
      @policy = BoardListPolicy
      include MvcStandardUpdateOperationConcern
    end
  end
end
