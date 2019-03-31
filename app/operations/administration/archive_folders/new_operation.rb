# frozen_string_literal: true

module Administration
  module ArchiveFolders
    class NewOperation < AdministrationOperation
      @form = ArchiveFolderForm
      include MvcStandardNewOperationConcern
    end
  end
end
