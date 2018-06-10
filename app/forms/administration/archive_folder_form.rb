# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class ArchiveFolderForm < Reform::Form
    feature Coercion
    model Folder

    property :name
    property :folder_id

    validation do
      configure do
        predicates(ReformPredicates)
      end

      required(:name).filled
    end
  end
end
