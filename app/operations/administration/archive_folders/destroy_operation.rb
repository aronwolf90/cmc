# frozen_string_literal: true

module Administration
  module ArchiveFolders
    class DestroyOperation < AdministrationOperation
      step Model(Folder, :find)
      step DestroyStep
    end
  end
end
