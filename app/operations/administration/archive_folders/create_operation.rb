# frozen_string_literal: true

module Administration
  module ArchiveFolders
    class CreateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(Folder, :new)
        step Contract::Build(constant: ArchiveFolderForm)
      end

      include Concerns::StandartTrailblazerSteps
    end
  end
end
