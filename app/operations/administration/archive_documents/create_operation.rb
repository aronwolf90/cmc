# frozen_string_literal: true

module Administration
  module ArchiveDocuments
    class CreateOperation < AdministrationOperation
      @form = ArchiveDocumentForm
      include StandardCreateOperationConcern
    end
  end
end
