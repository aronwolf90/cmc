# frozen_string_literal: true

require "rails_helper"

describe Api::V1::DocumentDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        name: "test",
        "document-file-id": 1
      },
      relationships: {
        folder: {
          data: {
            id: 1,
            type: "folders"
          }
        }
      }
    }
  end
  let(:result) do
    {
      name: "test",
      document_file_id: 1,
      folder_id: 1
    }
  end

  context "with comment in JSON-APi format" do
    it "deserialize to the Active Record format" do
      expect(subject).to eq(result)
    end
  end
end
