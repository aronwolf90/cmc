# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::ErrorSerializer do
  let(:errors) do
    {
      data: {
        attributes: {
          name: ["is missing"],
          "document-file-id": ["is missing"]
        }
      }
    }
  end
  let(:expected_result) do
    {
      errors: [
        {
          source: { pointer: "data/attributes/name" },
          detail: "is missing"
        },
        {
          source: { pointer: "data/attributes/document-file-id" },
          detail: "is missing"
        }
      ]
    }
  end

  it "serialize record in the correct way" do
    expect(described_class.(errors)).to eq expected_result
  end
end
