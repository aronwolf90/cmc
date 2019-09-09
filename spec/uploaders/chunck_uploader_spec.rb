# frozen_string_literal: true

require "rails_helper"

RSpec.describe BaseUploader do
  specify do
    document_file = DocumentFile.new(file: "test.txt")
    uploader = ChunckUploader.new(document_file)

    uploader.start_mulipart_upload
    uploader.upload_part("123")
    uploader.complete_multipart_upload
    expect(uploader.s3_file.body).to eq "123"
  end
end
