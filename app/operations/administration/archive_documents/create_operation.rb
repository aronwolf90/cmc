# frozen_string_literal: true

module Administration
  module ArchiveDocuments
    class CreateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(Document, :new)
        step Contract::Build(constant: ArchiveDocumentForm)
      end

      include Concerns::StandartTrailblazerSteps
    end
  end
end
