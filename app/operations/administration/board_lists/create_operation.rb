# frozen_string_literal: true

module Administration
  module BoardLists
    class CreateOperation < AdministrationOperation
      @form = BoardListForm
      include StandardCreateOperationConcern
    end
  end
end
