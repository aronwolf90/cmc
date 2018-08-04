# frozen_string_literal: true

module Administration
  module ArchiveFolders
    class UpdateOperation < AdministrationOperation
      @form = ArchiveFolderForm
      include StandardUpdateOperationConcern
    end
  end
end