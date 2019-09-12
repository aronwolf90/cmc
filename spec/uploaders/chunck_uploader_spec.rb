# frozen_string_literal: true

require "rails_helper"

RSpec.describe ChunckUploader do
  it "multipart upload" do
    document_file = DocumentFile.new(file: "test.txt")
    uploader = ChunckUploader.new(document_file)

    uploader.start_mulipart_upload
    uploader.upload_part("123")
    uploader.complete_multipart_upload
    expect(uploader.s3_file.body).to eq "123"
  end

  describe ".url" do
    let(:document_file) { create(:document_file, file: "avatar.png") }
    let(:file) { Rails.root.join("spec", "fixtures", "avatar.png") }

    before { described_class.new(document_file).upload(file)  }

    it "return the aws url" do
      expect(described_class.url(document_file)).to match(/http:.*/)
    end
  end
end
