# frozen_string_literal: true

module Administration
  module ArchiveDocuments
    class DestroyOperation < AdministrationOperation
      step Model(Document, :find)
      step DestroyStep
    end
  end
end
