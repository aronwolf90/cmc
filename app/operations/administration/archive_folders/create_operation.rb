# frozen_string_literal: true

module Administration
  module ArchiveFolders
    class CreateOperation < AdministrationOperation
      @form = ArchiveFolderForm
      @policy = FolderPolicy
      include MvcStandardCreateOperationConcern
    end
  end
end
