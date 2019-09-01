# frozen_string_literal: true

class DocumentFile < ApplicationRecord
  mount_uploader :file, DocumentUploader

  has_one :document
end
