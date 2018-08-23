# frozen_string_literal: true

module Administration
  module Records
    class UpdateOperation < AdministrationOperation
      @form = RecordForm
      include MvcStandardUpdateOperationConcern
    end
  end
end
