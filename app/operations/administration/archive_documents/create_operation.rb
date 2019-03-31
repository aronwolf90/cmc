# frozen_string_literal: true

module Administration
  module ArchiveDocuments
    class CreateOperation < AdministrationOperation
      include MvcStandardCreateOperationConcern
    end
  end
end
