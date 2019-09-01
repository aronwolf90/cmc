# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::DocumentFileSerializer, type: :serializer do
  let(:document_file) { build_stubbed(:document_file) }

  let(:expected_result) do
    {
      data: {
        id: document_file.id.to_s,
        type: "document-files",
      }
    }
  end

  it "serialize record in the correct way" do
    expect(serialize(document_file)).to eql expected_result
  end
end
