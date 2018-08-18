# frozen_string_literal: true

module Administration
  module ArchiveFolders
    class DestroyOperation < AdministrationOperation
      step Model(Folder, :find)
      step Policy::Pundit(FolderPolicy, :destroy?)
      step DestroyStep
    end
  end
end
