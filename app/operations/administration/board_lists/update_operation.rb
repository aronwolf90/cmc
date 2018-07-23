# frozen_string_literal: true

module Administration
  module BoardLists
    class UpdateOperation < AdministrationOperation
      @form = BoardListForm
      include StandardUpdateOperationConcern
    end
  end
end
