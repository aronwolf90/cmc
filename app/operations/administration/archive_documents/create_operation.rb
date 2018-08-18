# frozen_string_literal: true

module Administration
  module ArchiveDocuments
    class CreateOperation < AdministrationOperation
      @form = ArchiveDocumentForm
      @policy = DocumentPolicy
      include MvcStandardCreateOperationConcern
    end
  end
end
