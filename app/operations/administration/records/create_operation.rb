# frozen_string_literal: true

module Administration
  module Records
    class CreateOperation < AdministrationOperation
      @form = RecordForm
      include MvcStandardCreateOperationConcern
    end
  end
end
