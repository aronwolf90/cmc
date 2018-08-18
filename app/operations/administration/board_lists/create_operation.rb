# frozen_string_literal: true

module Administration
  module BoardLists
    class CreateOperation < AdministrationOperation
      @form = BoardListForm
      @policy = BoardListPolicy
      include MvcStandardCreateOperationConcern
    end
  end
end
