# frozen_string_literal: true

class Document < ApplicationRecord
  belongs_to :folder
  belongs_to :document_file

  def download_name
    name.parameterize.underscore +
      File.extname(document_file.file).downcase
  end
end
