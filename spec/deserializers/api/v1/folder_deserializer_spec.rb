# frozen_string_literal: true

require "rails_helper"

describe Api::V1::FolderDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        name: "test",
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
      folder_id: 1
    }
  end

  context "with comment in JSON-APi format" do
    it "deserialize to the Active Record format" do
      expect(subject).to eq(result)
    end
  end
end
