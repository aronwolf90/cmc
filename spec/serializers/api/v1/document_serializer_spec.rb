# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::DocumentSerializer, type: :serializer do
  let(:folder) { build_stubbed(:folder) }
  let(:document_file) { build_stubbed(:document_file) }
  let(:document) do
    build_stubbed(
      :document,
      folder: folder,
      document_file: document_file
    )
  end
  let(:expected_result) do
    {
      data: {
        id: document.id.to_s,
        type: "documents",
        attributes: {
          name: document.name,
          url: "/api/v1/document_files/#{document_file.id}"
        },
        relationships: {
          folder: {
            data: {
              id: folder.id.to_s,
              type: "folders"
            }
          }
        },
        links: { self: "/api/v1/documents/#{document.id}" }
      }
    }
  end

  it "serialize document in the correct way" do
    expect(serialize(document)).to eq expected_result
  end
end
