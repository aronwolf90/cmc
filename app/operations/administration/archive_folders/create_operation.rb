# frozen_string_literal: true

module Administration
  module ArchiveFolders
    class CreateOperation < AdministrationOperation
      @form = ArchiveFolderForm
      include StandardCreateOperationConcern
    end
  end
end
