# frozen_string_literal: true

require "rails_helper"

describe Api::V1::WikiPageDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      id: "1",
      type: "users",
      attributes: {
        title: "new title",
        content: "new content"
      },
      relationships: {
        "wiki-category": {
          data: {
            id: 1, type: "wiki-categories"
          }
        }
      }
    }
  end
  let(:result) do
    {
      title: "new title",
      content: "new content",
      wiki_category_id: 1
    }
  end

  it "deserialized correctly" do
    expect(subject).to eq(result)
  end
end
