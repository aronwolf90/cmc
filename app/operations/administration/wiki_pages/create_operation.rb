# frozen_string_literal: true

module Administration
  module WikiPages
    class CreateOperation < AdministrationOperation
      @form = WikiPageForm
      include StandardCreateOperationConcern
    end
  end
end
