# frozen_string_literal: true

require "rails_helper"

describe Administration::WikiPageForm do
  subject { described_class.new(wiki_page) }

  let(:wiki_page) do
    build_stubbed(:wiki_page, wiki_category: parent_category)
  end
  let(:parent_category) { build_stubbed(:wiki_category)  }

  it { expect(subject.validate({})).to be true }
  it { expect(subject.validate(title: nil)).to be false }
  it { expect(subject.validate(wiki_category_id: nil)).to be false }
end
