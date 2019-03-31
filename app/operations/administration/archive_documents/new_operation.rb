# frozen_string_literal: true

module Administration
  module ArchiveDocuments
    class NewOperation < AdministrationOperation
      @form = ArchiveDocumentForm
      include MvcStandardNewOperationConcern
    end
  end
end
