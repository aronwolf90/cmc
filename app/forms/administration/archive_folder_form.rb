# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class ArchiveFolderForm < ApplicationForm
    model Folder

    property :name
    property :folder_id

    validates :name, presence: true
  end
end
