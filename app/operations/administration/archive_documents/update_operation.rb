# frozen_string_literal: true

module Administration
  module ArchiveDocuments
    class UpdateOperation < AdministrationOperation
      @form = ArchiveDocumentForm
      @policy = DocumentPolicy
      include MvcStandardUpdateOperationConcern
    end
  end
end
