# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::WikiPageSerializer, type: :serializer do
  let(:wiki_category) { build_stubbed(:wiki_category) }
  let(:wiki_page) { build_stubbed(:wiki_page, wiki_category: wiki_category)  }
  let(:expected_result) do
    { data: {
      id: wiki_page.id.to_s,
      type: "wiki-pages",
      attributes: {
        title: "wiki page title",
        content: "wiki page content"
      },
      relationships: {
        "wiki-category": { data: {
          id: wiki_category.id.to_s,
          type: "wiki-categories"
        } },
      },
      links: { self: "/api/v1/wiki_pages/#{wiki_page.id}" }
    } }
  end

  it "serialize wiki page in the correct way" do
    expect(serialize(wiki_page)).to eq expected_result
  end
end
