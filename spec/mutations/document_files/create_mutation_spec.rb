# frozen_string_literal: true

require "rails_helper"

RSpec.describe DocumentFiles::CreateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: DocumentFile.new,
      file: Rack::Test::UploadedFile.new(chunck)
    )
  end

  let(:current_user) { create(:employee) }
  let(:chunck) do
    Tempfile.new.tap do |file|
      file.write "123456"
      file.rewind
    end
  end

  after do
    chunck.close
    chunck.unlink
  end

  it "add chuck" do
    subject
    uploader = ChunckUploader.new(DocumentFile.last)
    expect(uploader.s3_file.body).to eq("123456")
  end

  context "when finish is passed as query parameter" do
    subject do
      described_class.call(
        user: current_user,
        model: DocumentFile.new,
        file: Rack::Test::UploadedFile.new(chunck),
        not_finished: true
      )
    end

    it "add chuck" do
      subject
      uploader = ChunckUploader.new(DocumentFile.last)
      uploader.complete_multipart_upload
      expect(uploader.s3_file.body).to eq("123456")
    end
  end
end
