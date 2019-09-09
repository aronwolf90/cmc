# frozen_string_literal: true

require "rails_helper"

RSpec.describe DocumentFiles::UpdateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model,
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
  let(:model) { create(:document_file, file: "test.txt") }

  after do
    chunck.close
    chunck.unlink
  end

  specify do
    uploader = ChunckUploader.new(model)
    uploader.start_mulipart_upload
    model.save!
    subject
    expect(uploader.s3_file.body).to eq("123456")
  end

  context "when not_finish is passed as query parameter" do
    subject do
      described_class.call(
        user: current_user,
        model: model,
        file: Rack::Test::UploadedFile.new(chunck),
        not_finished: true
      )
    end

    it "add chuck" do
      uploader = ChunckUploader.new(model)
      uploader.start_mulipart_upload
      model.save!
      subject
      uploader.complete_multipart_upload
      expect(uploader.s3_file.body).to eq("123456")
    end
  end
end
