# frozen_string_literal: true

module Administration
  module WikiPages
    class NewOperation < AdministrationOperation
      @form = WikiPageForm
      include MvcStandardNewOperationConcern
    end
  end
end
