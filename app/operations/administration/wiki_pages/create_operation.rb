# frozen_string_literal: true

module Administration
  module WikiPages
    class CreateOperation < AdministrationOperation
      @form = WikiPageForm
      @policy = WikiPagePolicy
      include MvcStandardCreateOperationConcern
    end
  end
end
