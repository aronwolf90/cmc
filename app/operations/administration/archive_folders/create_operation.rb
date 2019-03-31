# frozen_string_literal: true

module Administration
  module ArchiveFolders
    class CreateOperation < AdministrationOperation
      include MvcStandardCreateOperationConcern
    end
  end
end
