# frozen_string_literal: true

module Administration
  module Records
    class NewOperation < AdministrationOperation
      @form = RecordForm
      include MvcStandardNewOperationConcern
    end
  end
end
