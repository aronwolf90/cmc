# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class ArchiveDocumentForm < Reform::Form
    feature Coercion
    model Document

    property :name
    property :folder_id
    property :file
    property :file_cache

    validation do
      configure do
        predicates(ReformPredicates)

        def file_present?(file)
          file.respond_to?(:original_filename)
        end
      end

      required(:name).filled
      required(:folder_id).filled
      required(:file).filled(:file_present?)
    end
  end
end
