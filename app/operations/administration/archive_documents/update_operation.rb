# frozen_string_literal: true

module Administration
  module ArchiveDocuments
    class UpdateOperation < AdministrationOperation
      @form = ArchiveDocumentForm
      include MvcStandardUpdateOperationConcern
    end
  end
end
