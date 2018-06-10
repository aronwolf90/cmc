# frozen_string_literal: true

class Document < ApplicationRecord
  mount_uploader :file, DocumentUploader
  belongs_to :folder

  def download_name
    name.parameterize.underscore + File.extname(file.path).downcase
  end
end
