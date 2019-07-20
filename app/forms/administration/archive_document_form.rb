# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class ArchiveDocumentForm < ApplicationForm
    model Document

    property :name
    property :folder_id
    property :file
    property :file_cache

    validates :name, presence: true
    validates :folder_id, presence: true
    validate :file_present

    def file_present
      return if file.respond_to?(:original_filename)
      return if model.file.file.respond_to?(:original_filename)

      errors.add(:file, :blank)
    end
  end
end
