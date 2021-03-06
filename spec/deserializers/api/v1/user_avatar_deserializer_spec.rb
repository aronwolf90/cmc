# frozen_string_literal: true

require "rails_helper"

describe Api::V1::UserAvatarDeserializer do
  subject { described_class.call(params) }

  let(:file) { Rack::Test::UploadedFile.new(File.open(Rails.root.join("spec", "fixtures", "avatar.png"))) }
  let(:params) do
    {
      file: file
    }
  end
  let(:result) do
    {
      file: file,
    }
  end

  context "with comment in JSON-APi format" do
    it "deserialize to the Active Record format" do
      expect(subject).to eq(result)
    end
  end
end
