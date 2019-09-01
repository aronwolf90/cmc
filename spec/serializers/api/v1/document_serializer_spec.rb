# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::DocumentSerializer, type: :serializer do
  let(:folder) { build_stubbed(:folder) }
  let(:document) { build_stubbed(:document, folder: folder) }
  let(:expected_result) do
    {
      data: {
        id: document.id.to_s,
        type: "documents",
        attributes: {
          name: document.name
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
