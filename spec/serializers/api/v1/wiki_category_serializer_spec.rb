# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::WikiCategorySerializer, type: :serializer do
  let(:child_wiki_category) { build_stubbed(:wiki_category)  }
  let(:wiki_category) do
    build_stubbed(:wiki_category, wiki_categories: [child_wiki_category])
  end
  let(:expected_result) do
    { data: {
      id: wiki_category.id.to_s,
      type: "wiki-categories",
      attributes: {
        title: wiki_category.title,
        root: true
      },
      relationships: {
        "wiki-category": { data: nil },
        "wiki-categories": {
          data: [{
            id: child_wiki_category.id.to_s,
            type: "wiki-categories"
          }]
        },
        "wiki-pages": { data: []  }
      }
    } }
  end

  it "serialize record in the correct way" do
    expect(serialize(wiki_category)).to eq expected_result
  end
end
