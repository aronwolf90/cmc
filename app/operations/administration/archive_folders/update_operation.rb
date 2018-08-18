# frozen_string_literal: true

module Administration
  module ArchiveFolders
    class UpdateOperation < AdministrationOperation
      @form = ArchiveFolderForm
      @policy = FolderPolicy
      include MvcStandardUpdateOperationConcern
    end
  end
end
