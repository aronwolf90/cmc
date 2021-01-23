# frozen_string_literal: true

require "rails_helper"

describe Api::V1::WikiCategoryDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        title: "Title",
      },
      relationships: {
        "wiki-category": {
          data: {
            id: 1,
            type: "wiki-categories"
          }
        }
      }
    }
  end
  let(:result) do
    {
      title: "Title",
      wiki_category_id: 1
    }
  end

  context "with comment in JSON-APi format" do
    it "deserialize to the Active Record format" do
      expect(subject).to eq(result)
    end
  end
end
